import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tugas_4/home.dart';
import 'customer_016.dart';
import 'package:tugas_4/service/db_helperr.dart';
import 'input_016.dart';
import 'update_016.dart';


class Home_016 extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home_016> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.people_outline),
        title: Text('Data Customers'),
        backgroundColor: Colors.blue.shade200,
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
      body: Container(
        color: Colors.white,
        child: FutureBuilder<List<Customer016>>(
          future: Database_Helper.instance.getAllCustomer_016(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Customer016>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text('Loading...'),
              );
            }
            return snapshot.data!.isEmpty
                ? Center(
                    child: Text('Tidak ada data'),
                  )
                : ListView(
                    children: snapshot.data!.map((customer) {
                      return Center(
                        child: Card(
                          color: Colors.blue.shade100,
                          child: ListTile(
                            title: Text(
                              customer.nama,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                'Alamat : ${customer.alamat}\nEmail : ${customer.email}\nNo HP : +62 ${customer.no_hp}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Update_016(
                                                id: customer.id,
                                                nama: customer.nama,
                                                alamat: customer.alamat,
                                                email: customer.email,
                                                no_hp: customer.no_hp,
                                              ))),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () => _confirmDelete(customer.id),
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade200,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Input_016()));
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
                await Database_Helper.instance.delete(id);
                setState(() {});
                Navigator.pop(context);
                Fluttertoast.showToast(
                  msg: "Data berhasil dihapus!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.green.shade300,
                  textColor: Colors.white,
                );
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
