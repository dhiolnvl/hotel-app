import 'package:flutter/material.dart';
import 'petugas_044.dart';
import 'package:tugas_4/service/db_helperr.dart';
import 'home_044.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Update_Petugas044 extends StatefulWidget {
  Update_Petugas044(
      {required this.id,
      required this.nama,
      required this.bagian,
      required this.email,
      required this.no_hp});

  final int id;
  final String nama;
  final String bagian;
  final String email;
  final String no_hp;

  @override
  _Update_Petugas044State createState() => _Update_Petugas044State();
}

class _Update_Petugas044State extends State<Update_Petugas044> {
  @override
  void initState() {
    super.initState();
    nama_controller.text = widget.nama;
    bagian_controller.text = widget.bagian;
    email_controller.text = widget.email;
    no_hp_controller.text = widget.no_hp;
  }

  int? selectedId;
  final TextEditingController nama_controller = TextEditingController();
  final TextEditingController bagian_controller = TextEditingController();
  final TextEditingController email_controller = TextEditingController();
  final TextEditingController no_hp_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Data Petugas'),
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
                        await Database_Helper.instance.update_(
                          Petugas044(
                            id: widget.id,
                            nama: nama_controller.text,
                            bagian: bagian_controller.text,
                            email: email_controller.text,
                            no_hp: no_hp_controller.text,
                          ),
                        );
                        Fluttertoast.showToast(
                          msg: "Data berhasil diupdate!",
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
