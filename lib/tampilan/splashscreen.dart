// ignore_for_file: unnecessary_import, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/tampilan/login.dart';
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Delay 2 detik untuk menampilkan form login
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
    return Scaffold(
      body: Center(
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .center, // Menjadikan gambar dan teks ditengah secara horizontal
          mainAxisAlignment: MainAxisAlignment
              .center, // Menjadikan gambar dan teks ditengah secara vertical
          children: <Widget>[
            Image(
              image: AssetImage("assets/images/POLBENG.png"),
              width: 200,
              height: 200,
            ),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            Text(
              "PresensiApp",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            )
          ],
        )),
      ),
    );
  }
}