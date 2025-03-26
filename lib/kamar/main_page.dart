import 'package:flutter/material.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'dashboard.dart';
import 'tampil.dart';
import '/service/database_helper.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  Future<void> _addData() async {

    if (_no_kamarController.text.isEmpty ||
        _jenis_kamarController.text.isEmpty ||
        _tarifController.text.isEmpty ||
        _fasilitasController.text.isEmpty ||
        _statusController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red, content: Text("Semua harus diisi!")),
      );
      return;
    }

    int tarif = int.tryParse(_tarifController.text) ?? -1;
    if (tarif < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tarif harus diisi dengan angka!")),
      );
      return;
    }

    bool cekNoKamar = await SQLHelper.cekNoKamarAda(_no_kamarController.text);
    if (cekNoKamar) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Nomor kamar sudah terdaftar!"),
        ),
      );
      return;
    }

    await SQLHelper.createData(
        _no_kamarController.text,
        _jenis_kamarController.text,
        tarif,
        _fasilitasController.text,
        _statusController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text("Data berhasil ditambahkan!"),
      ),
    );
  }

  final TextEditingController _no_kamarController = TextEditingController();
  final TextEditingController _jenis_kamarController = TextEditingController();
  final TextEditingController _tarifController = TextEditingController();
  final TextEditingController _fasilitasController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  void showBottom(int? id) async {
    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 20,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 50,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Tambah Data',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 49, 75, 224)),
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
                    hintText: "No Kamar",
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
                  maxLines: 3,
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
                  maxLines: 3,
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
                      if (id == null) {
                        await _addData();
                      }

                      _no_kamarController.text = "";
                      _jenis_kamarController.text = "";
                      _fasilitasController.text = "";
                      _tarifController.text = "";
                      _statusController.text = "";

                      Navigator.of(context).pop();
                      print("Data Berhasil DiTambah!");
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Tambah Data",
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
      ),
    );
  }

  final List<Widget> _children = [
    DashboardPage(),
    TampilPage(),
  ];

  int currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (currentIndex == 0)
          ? CalendarAppBar(
              accent: Color.fromARGB(255, 33, 150, 243),
              backButton: false,
              locale: 'id',
              onDateChanged: (value) => print(value),
              firstDate: DateTime.now().subtract(Duration(days: 140)),
              lastDate: DateTime.now(),
            )
          : PreferredSize(
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                    child: Text(
                      "Data Daftar Kamar",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'poppinsSm'),
                    ),
                  ),
                ),
              ),
              preferredSize: Size.fromHeight(100.0),
            ),
      floatingActionButton: Visibility(
        visible: currentIndex == 0 ? true : false,
        child: FloatingActionButton(
          onPressed: () => showBottom(null),
          backgroundColor: Color.fromARGB(255, 49, 75, 224),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),

      body: _children[currentIndex],


      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () {
                onTabTapped(0);
              },
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
              icon: Icon(
                Icons.list,
                color: Colors.white,
              ),
              onPressed: () {
                onTabTapped(1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
