import 'package:flutter/material.dart';
import '/service/database_helper.dart';

class TampilPage extends StatefulWidget {
  @override
  _TampilPageState createState() => _TampilPageState();
}

class _TampilPageState extends State<TampilPage> {
  
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;

  // Mengambil Semua Data Dari Database
  void _refreshData() async {
    final data = await SQLHelper.getAllData();
    setState(() {
      _allData = data;
      _isLoading = false;
    });
  }

  void initState() {
    super.initState();
    _refreshData();
  }

  // Ubah Data
  Future<void> _updateData(int id) async {
    // validasi input
    if (_no_kamarController.text.isEmpty ||
        _jenis_kamarController.text.isEmpty ||
        _tarifController.text.isEmpty ||
        _fasilitasController.text.isEmpty ||
        _statusController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text("Semua field harus diisi!")),
      );
      return;
    }

    // parse ke int
    int tarif = int.tryParse(_tarifController.text) ?? -1;
    if (tarif < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tarif harus berupa angka positif!")),
      );
      return;
    }

    await SQLHelper.updateData(
      id,
      _no_kamarController.text,
      _jenis_kamarController.text,
      tarif,
      _fasilitasController.text,
      _statusController.text,
    );
    _refreshData();

    // menampilkan snackbar kelitka sduah berhasil diubah
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text("Data berhasil diubah!"),
      ),
    );
  }

  // validasi hapus data
  Future<void> _confirmDelete(int id) async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi Penghapusan"),
          content: Text("Apakah Anda yakin ingin menghapus data ini?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); 
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); 
              },
              child: Text("Hapus"),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await _deleteData(id);
    }
  }

  // Hapus Data
  Future<void> _deleteData(int id) async {
    await SQLHelper.deleteData(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("Data Terhapus"),
      ),
    );
    _refreshData();
  }

  final TextEditingController _no_kamarController = TextEditingController();
  final TextEditingController _jenis_kamarController = TextEditingController();
  final TextEditingController _tarifController = TextEditingController();
  final TextEditingController _fasilitasController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  void _showDetailDialog(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Detail Kamar", style: TextStyle(
          fontSize: 35,
          color: Colors.indigo,
          fontWeight: FontWeight.w500,
          fontFamily: 'poppinsSm'
        ),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider( color: Colors.indigo, thickness: 2, height: 20,),
            Text("1. No Kamar: ${data['no_kamar']}", style: TextStyle(fontSize: 20, fontFamily: 'poppinsR'), ),
            Text("2. Jenis Kamar: ${data['jenis_kamar']}", style: TextStyle(fontSize: 20, fontFamily: 'poppinsR')),
            Text("3. Fasilitas: ${data['fasilitas']},", style: TextStyle(fontSize: 20, fontFamily: 'poppinsR')),
            Text("4. Tarif: Rp. ${data['tarif']}", style: TextStyle(fontSize: 20, fontFamily: 'poppinsR')),
            Text("5. Status: ${data['status']}", style: TextStyle(fontSize: 20, fontFamily: 'poppinsR')),
            Divider( color: Colors.indigo, thickness: 2, height: 20,),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
            },
            child: Text("Tutup", style: TextStyle(
              fontSize: 14,
              color: Colors.indigo,
              fontWeight: FontWeight.w500
            ),),
          ),
        ],
      ),
    );
  }

  void showBottom(int? id) async {
    if (id != null) {
      // Ambil data dari database berdasarkan id
      final data = await SQLHelper.getDataById(id);

      //  agar controller ada isi data lama
      _no_kamarController.text = data['no_kamar'];
      _jenis_kamarController.text = data['jenis_kamar'];
      _fasilitasController.text = data['fasilitas'];
      _tarifController.text = data['tarif'].toString();
      _statusController.text = data['status'];
    }

    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 10,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 30,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Ubah Data',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'poppinsSm'),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _no_kamarController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "NO Kamar",
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _jenis_kamarController,
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Jenis Kamar",
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _fasilitasController,
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Fasilitas",
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _tarifController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Tarif",
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _statusController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Status",
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () async {
                    if (id != null) {
                      await _updateData(id);
                    }

                    _no_kamarController.text = "";
                    _jenis_kamarController.text = "";
                    _fasilitasController.text = "";
                    _tarifController.text = "";
                    _statusController.text = "";

                    // Menyembunyikan Bottom Sheet
                    Navigator.of(context).pop();
                    print("Data Berhasil DiUbah!");
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      id != null ? "Ubah Data" : "",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: _allData.length,
            itemBuilder: (context, index) => Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.blue, 
                  width: 2, 
                ),
                borderRadius: BorderRadius.circular(10), 
              ),
              margin: EdgeInsets.all(15),
              child: ListTile(
                title: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.indigo,
                        ),
                        padding: EdgeInsets.all(4),
                        child: Text(
                          _allData[index]['no_kamar'],
                          style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'poppinsR'),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        _allData[index]['jenis_kamar'],
                        style: TextStyle(fontSize: 20, fontFamily: 'poppinsR'),
                      ),
                      Text(
                        _allData[index]['status'],
                        style: TextStyle(fontSize: 15, fontFamily: 'poppinsR'),
                      ),
                    ],
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        _showDetailDialog(_allData[index]);
                      },
                      icon: Icon(
                        Icons.visibility,
                        color: Colors.indigo,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showBottom(_allData[index]['id']);
                      },
                      icon: Icon(
                        Icons.edit,
                        color: const Color.fromARGB(255, 146, 135, 39),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _confirmDelete(_allData[index]['id']);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
