import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'customer_016.dart';
import 'package:tugas_4/service/db_helperr.dart';
import 'home_016.dart';

class Input_016 extends StatefulWidget {
  @override
  _Input_016State createState() => _Input_016State();
}

class _Input_016State extends State<Input_016> {
  int selectedId = 0;
  final TextEditingController nama_controller = TextEditingController();
  final TextEditingController alamat_controller = TextEditingController();
  final TextEditingController email_controller = TextEditingController();
  final TextEditingController no_hp_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Data Customers'),
        backgroundColor: Colors.blue.shade200,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: nama_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.people),
                  hintText: 'Tuliskan Nama',
                  labelText: 'Nama',
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: alamat_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_city),
                  hintText: 'Tuliskan Alamat',
                  labelText: 'Alamat',
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: email_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Tuliskan Email',
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: no_hp_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  hintText: 'Tuliskan nomer telepon',
                  labelText: 'No HP',
                  prefixText: '+62 ',
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (nama_controller.text.isEmpty ||
                      alamat_controller.text.isEmpty ||
                      email_controller.text.isEmpty ||
                      no_hp_controller.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: "Semua field harus diisi!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red.shade300,
                      textColor: Colors.white,
                    );
                  } else if (no_hp_controller.text.length < 12) {
                    Fluttertoast.showToast(
                      msg: "Nomor telepon harus terdiri dari 12 digit!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red.shade300,
                      textColor: Colors.white,
                    );
                  } else {
                    await Database_Helper.instance.add(
                      Customer016(
                        id: 0,
                        nama: nama_controller.text,
                        alamat: alamat_controller.text,
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
                      MaterialPageRoute(builder: (context) => Home_016()),
                      (Route<dynamic> route) => false,
                    );
                  }
                },
                child: Text(
                  'Simpan',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
