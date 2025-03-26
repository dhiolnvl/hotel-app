import 'package:flutter/material.dart';
import 'package:tugas_4/home.dart';
import 'package:tugas_4/petugas/update_044.dart';
import 'petugas_044.dart';
import 'package:tugas_4/service/db_helperr.dart';
import 'input_044.dart';

class Home_044 extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home_044> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.work),
        title: Text('Data Petugas'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Menu_Kel()));
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Petugas044>>(
        future: Database_Helper.instance.getAllPetugas044(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Petugas044>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('Loading...'),
            );
          }
          return snapshot.data!.isEmpty
              ? Center(
                  child: Text('Tidak Ada Data Yang dimasukkan'),
                )
              : ListView(
                  children: snapshot.data!.map((petugas) {
                    return Center(
                      child: Card(
                        color: Colors.white70,
                        child: ListTile(
                          title: Text(petugas.nama),
                          subtitle: Text(
                              'Bagian : ${petugas.bagian}\nEmail : ${petugas.email}\nNo Hp : ${petugas.no_hp}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Update_Petugas044(
                                              id: petugas.id,
                                              nama: petugas.nama,
                                              bagian: petugas.bagian,
                                              email: petugas.email,
                                              no_hp: petugas.no_hp,
                                            ))),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => _confirmDelete(petugas.id),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => (Input_Petugas044())));
        },
      ),
    );
  }

  void _confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Hapus Data'),
          content: Text('Apakah Anda yakin ingin menghapus data ini?'),
          actions: [
            TextButton(
              child: Text('Hapus'),
              onPressed: () async {
                await Database_Helper.instance.delete_(id);
                setState(() {});
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            
          ],
        );
      },
    );
  }
}
