import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'dashboard.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    // Periksa status login setelah splash screen muncul
    Future.delayed(Duration(seconds: 3), () {
      bool isLoggedIn = box.read('isLoggedIn') ?? false; // Baca status login
      String username = box.read('email') ?? 'User';

      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardScreen(username: username),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 300,
              height: 300,
            ),
            SizedBox(height: 20),
            Text(
              'KLATEN EXPLORE ONLINE',
              style: TextStyle(
                color: const Color(0xFF61AB32),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
