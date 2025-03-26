import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'register_page.dart';

class HomePage extends StatelessWidget {
  Future<void> _logout(BuildContext context) async {
    // Hapus data login yang disimpan di SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Navigasi ke halaman login
    Navigator.of(context).pushReplacementNamed('/login');
  }

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
                // Navigasi ke halaman login saat logout
                Navigator.pushReplacementNamed(context, '/login');
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 130, 16, 16),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Text("Selamat Datang", style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue
                    ),),
                    Text("di Hotel", style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue
                    ),)
                  ],
                ),
              ),
              Container(
                width: 300,
                height: 300,
                child: Image.asset('assets/images/hotel.png'),
              ),
              Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                ),
                child: MaterialButton(
                  child: Text("Login", style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),),
                  onPressed: (){
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
                  }
                  ),
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2
                  ),
                  color: Colors.white,
                ),
                child: MaterialButton(
                  child: Text("Register", style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20
                  ),),
                  onPressed: (){
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage2()));
                  }
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
