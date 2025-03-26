import 'package:flutter/material.dart';
import '/service/database_helper.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<DashboardPage> {
  
  int _jumlahKamar = 0;
  int _jumlahKamarTersedia = 0; 
  int _jumlahKamarTidakTersedia = 0; 


  void _getJumlahKamar() async {
    int count = await SQLHelper.getKamarCount();
    setState(() {
      _jumlahKamar = count;
    });
  }


  void _getJumlahKamarTersedia() async {
    int count = await SQLHelper.getJumlahKamartersedia();
    setState(() {
      _jumlahKamarTersedia = count;
    });
  }


  void _getJumlahKamarTidakTersedia() async {
    int count = await SQLHelper.getJumlahKamarTidaktersedia();
    setState(() {
      _jumlahKamarTidakTersedia = count;
    });
  }

  @override
  void initState() {
    super.initState();
    _getJumlahKamar(); 
    _getJumlahKamarTersedia(); 
    _getJumlahKamarTidakTersedia(); 
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 183, 183, 184),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.2), 
                      spreadRadius: 2, 
                      blurRadius: 4, 
                      offset: Offset(1, 1), 
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Dashboard Daftar Kamar',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.indigo,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'poppinsSm'),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Text(
                "Statistik Kamar",
                style: TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.bold,
                  fontFamily: 'poppinsR'
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                  0.2),
                              spreadRadius: 5,
                              blurRadius: 7, 
                              offset: Offset(0, 4), 
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(left: 30),
                        width: 150,
                        height: 150,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Jumlah Kamar',
                              style:
                                  TextStyle(
                                    color: Colors.white, 
                                    fontSize: 16,
                                    fontFamily: 'poppinsR'
                                    ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '$_jumlahKamar',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'poppinsR'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 30),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                  0.2), 
                              spreadRadius: 5,
                              blurRadius: 7, 
                              offset: Offset(0, 4), 
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(right: 30),
                        width: 150,
                        height: 150,
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Text(
                              'Kamar Tersedia',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'poppinsR'),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '$_jumlahKamarTersedia', 
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'poppinsR'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 146, 136, 43),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                  0.2), 
                              spreadRadius: 5, 
                              blurRadius: 7, 
                              offset: Offset(0, 4), 
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(left: 30),
                        width: 150,
                        height: 150,
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Container(
                              padding: EdgeInsets.only(left: 30, right: 20),
                              child: Text(
                                'Kamar Tdk Tersedia',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16, fontFamily: 'poppinsR'),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '$_jumlahKamarTidakTersedia', 
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'poppinsR'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 30),  
                      Container(
                        child: MaterialButton(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue,
                            ),
                            width: 100,
                            height: 50,
                            child: Center(
                              child: Text("Kembali", style: TextStyle(
                                color: Colors.white,
                                fontSize: 20
                              ),),
                            ),
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                          }
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
