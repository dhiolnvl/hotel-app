import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'kamar/main_page.dart';
import 'petugas/home_044.dart';
import 'customer/home_016.dart';
import 'tentang/tentang.dart';

class Menu_Kel extends StatelessWidget {
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi Logout"),
          content: Text("Apakah Anda yakin ingin logout?"),
          actions: [
            TextButton(
              child: Text("Batal"),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
            ),
            TextButton(
              child: Text("Logout"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login2');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Menu Utama",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () => _showLogoutDialog(context),
            ),
          ],
          backgroundColor: Colors.blueAccent,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('Selamat Datang'),
              ),
              Divider(),
              ListTile(
                title: Text('Customer'),
                trailing: Icon(
                  Icons.people,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Home_016()));
                },
              ),
              ListTile(
                title: Text('Petugas'),
                trailing: Icon(Icons.supervised_user_circle),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Home_044()));
                },
              ),
              ListTile(
                title: Text('Kamar'),
                trailing: Icon(Icons.king_bed),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainPage()));
                },
              ),
              ListTile(
                title: Text('Tentang'),
                trailing: Icon(Icons.info),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Tentang_Kel()));
                },
              ),
            ],
          ),
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
                        "Selamat Datang",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'BaksoSapi',
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Di halaman menu utama aplikasi",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "dari kelompok kami ",
                        style: TextStyle(
                          fontSize: 20,
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: MaterialButton(
                        child: Container(
                          width: 380,
                          height: 130,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color(0xff3077f4),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(13, 15, 0, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Customer",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'BaksoSapi',
                                                fontSize: 25,
                                              )),
                                          Text("Berisi tentang data customer",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 100,
                                height: 100,
                                child:
                                    Image.asset("assets/images/customer.png"),
                              )
                            ],
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Home_016()));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: MaterialButton(
                        child: Container(
                          width: 380,
                          height: 130,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xff3077f4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(13, 15, 0, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Petugas",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'BaksoSapi',
                                                fontSize: 25,
                                              )),
                                          Text("Berisi tentang data petugas",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                width: 100,
                                height: 100,
                                child: Image.asset("assets/images/petugas.png"),
                              )
                            ],
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Home_044()));
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: MaterialButton(
                        child: Container(
                          width: 380,
                          height: 130,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color(0xff3077f4),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(13, 15, 0, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Kamar",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'BaksoSapi',
                                                fontSize: 25,
                                              )),
                                          Text("Berisi tentang data kamar",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Container(
                                width: 100,
                                height: 100,
                                child: Image.asset("assets/images/kamar.png"),
                              )
                            ],
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage()));
                        },
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
