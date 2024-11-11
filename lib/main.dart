import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  // Menjamin inisialisasi widget Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase sebelum aplikasi dijalankan
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inisialisasi GetStorage
  await GetStorage.init();

  // Menjalankan aplikasi
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
      home: SplashScreen(), // Mengarah ke layar splash screen
    );
  }
}
