import 'package:flutter/material.dart';
import 'petugas_044.dart';
import 'package:tugas_4/service/db_helperr.dart';
import 'home_044.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Input_Petugas044 extends StatefulWidget {
  @override
  _Input_Petugas044State createState() => _Input_Petugas044State();
}

class _Input_Petugas044State extends State<Input_Petugas044> {
  int selectedId = 0;
  final TextEditingController nama_controller = TextEditingController();
  final TextEditingController bagian_controller = TextEditingController();
  final TextEditingController email_controller = TextEditingController();
  final TextEditingController no_hp_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Data Petugas'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                TextFormField(
                  controller: nama_controller,
                  decoration: InputDecoration(labelText: 'Nama'),
                ),
                TextFormField(
                  controller: bagian_controller,
                  decoration: InputDecoration(labelText: 'Bagian'),
                ),
                TextFormField(
                  controller: email_controller,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  controller: no_hp_controller,
                  decoration: InputDecoration(labelText: 'No Hp'),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (nama_controller.text.isEmpty ||
                          bagian_controller.text.isEmpty ||
                          email_controller.text.isEmpty ||
                          no_hp_controller.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Semua field harus diisi!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red.shade300,
                          textColor: Colors.white,
                        );
                      } else if (no_hp_controller.text.length < 11) {
                        Fluttertoast.showToast(
                          msg: "Nomor telepon harus terdiri dari 12 digit!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red.shade300,
                          textColor: Colors.white,
                        );
                      } else {
                        await Database_Helper.instance.add_(
                          Petugas044(
                            id: 0,
                            nama: nama_controller.text,
                            bagian: bagian_controller.text,
                            email: email_controller.text,
                            no_hp: no_hp_controller.text,
                          ),
                        );
                        Fluttertoast.showToast(
                          msg: "Data berhasil disimpan!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.green.shade300,
                          textColor: Colors.white,
                        );
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Home_044()),
                            (Route<dynamic> route) => false);
                      }
                    },
                    child: Text('Simpan')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
