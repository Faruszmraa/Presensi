import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/tampilan/dashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen ({super.key});
  @override
  State<LoginScreen> createState(){
    return _LoginScreen();
  }
}



class _LoginScreen extends State<LoginScreen> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  
  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silahkan masukkan nama pengguna dan password')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    const url = 'https://presensi.splime.id/login'; 
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );
    if (kDebugMode) {
      print(response.statusCode);
    }
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final nik = responseBody['nik'];
      final token = responseBody['token'];
      final name = responseBody['nama'];
      final dept = responseBody['departemen'];
      final imgUrl = responseBody['imgurl'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt', token);
      await prefs.setString('name', name);
      await prefs.setString('dept', dept);
      await prefs.setString('imgProfil', imgUrl);
      await prefs.setString('nik', nik);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DashboardScreen()),
        (route) => false
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Polbeng',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/images/POLBENG.png'),
                  height: 100.0,
                ),
                Text(
                  'Selamat Datang di ',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'PresensiApp',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: 20,
                ), // Menambahkan jarak antara teks dan form input
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ), // Menambahkan sedikit jarak antara form input
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ), // Membuat jarak untuk ikon peringatan
                    Icon(
                      Icons.warning,
                      color: Colors.red,
                    ), // Icon peringatan
                    SizedBox(
                      width: 8,
                    ), // Jarak antara icon dan teks
                    Text(
                      'Invalid email address',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ), // Menambahkan jarak antara form input
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.visibility), // Ikon mata
                        onPressed: () {
                          // Logika saat ikon ditekan
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ), // Menambahkan sedikit jarak antara form input
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ), // Membuat jarak untuk ikon peringatan
                    Icon(
                      Icons.warning,
                      color: Colors.red,
                    ), // Icon peringatan
                    SizedBox(
                      width: 8,
                    ), // Jarak antara icon dan teks
                    Text(
                      'Invalid password',
                      style: TextStyle(color: Colors.red),
                    ),
                    Spacer(), // Spacer untuk mendorong teks ke pojok kanan
                    TextButton(
                      onPressed: () {
                        // Tambahkan logika saat tombol "Lupa Password" ditekan
                      },
                      child: Text(
                        'Lupa Password',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ), // Menambahkan jarak antara form input dan tombol
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DashboardScreen()));
                    },
                    child: Text(
                      'Masuk',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blue, // Mengatur warna tombol menjadi biru
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ),
                SizedBox(
                    height:
                        30), // Menambahkan jarak antara tombol Masuk dan teks "Masuk dengan sidik jari?"
                Text('Masuk dengan sidik jari?',
                    style: TextStyle(color: Colors.grey, fontSize: 17)),

                SizedBox(
                    height:
                        10), // Menambahkan jarak antara tombol Masuk dan teks "Masuk dengan sidik jari?"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.fingerprint,
                      color: Colors.black,
                      size: 55,
                    ), // Icon sidik jari
                    SizedBox(width: 8), // Jarak antara icon dan teks
                  ],
                ),

                SizedBox(height: 20),
                Text("Belum punya akun?"),
                Text("Daftar",
                    style: TextStyle(color: Colors.purple, fontSize: 15)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
