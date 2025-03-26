import 'package:flutter/material.dart';

class Tentang_Kel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white), // Ikon kustom
            onPressed: () {
              Navigator.pop(context); // Kembali ke layar sebelumnya
            },
          ),
          title: Text(
            "Tentang",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
          actions: <Widget>[],
          backgroundColor: Colors.blueAccent,
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Column(
                    children: [
                      Text(
                        "Tentang  Kami",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'BaksoSapi',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      width: 300,
                      height: 300,
                      child: Image.asset("assets/images/tentang.png"),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 380,
                        height: 600,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(13, 15, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "Kelompok 1, yang beranggotakan 3 Mahasiswa, mengerjakan Tugas 4, membuat aplikasi mobile memakai framework flutter berbasis database menggunakan Sqfilte, Kami membuat aplikasi dengan tema pengelolaan hotel, yang berisi data customer, data petugas, dan data kamar. kita juga membuat menu login dan register.",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )));
  }
}
