// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter_application_1/tampilan/splashscreen.dart';
import 'package:intl/date_symbol_data_local.dart';

Future <void>  main() async {
  await initializeDateFormatting('id',null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Presensei App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}




