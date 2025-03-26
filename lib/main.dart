import 'package:flutter/material.dart';
import 'auth/home_page.dart';
import 'auth/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login2',
      routes: {
        '/login2': (context) => HomePage(),
      },
    );
  }
}
