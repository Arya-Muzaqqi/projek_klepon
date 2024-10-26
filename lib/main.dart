import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'login.dart';
import 'firebase_options.dart'; // Import Firebase options (hasil dari FlutterFire CLI)

void main() async {
  // Menjamin inisialisasi widget Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase sebelum aplikasi dijalankan
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Mengambil opsi berdasarkan platform
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KLEPON',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(), // Mengarah ke layar login
    );
  }
}
