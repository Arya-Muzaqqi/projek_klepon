import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'dashboard.dart';
import 'dashboard_admin.dart';
import 'penjaga.dart'; // Import the new Penjaga screen
import 'register.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final box = GetStorage();
  String _errorMessage = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  get email => null;

  void _login() async {
    try {
      // Sign-in using Firebase Authentication
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Check if the user is admin, penjaga, or a regular user based on email
      if (userCredential.user?.email == 'admin@example.com') {
        box.write('isLoggedIn', true);
        box.write('email', userCredential.user!.email);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DashboardAdminScreen(username: userCredential.user!.email!),
          ),
        );
      } else if (userCredential.user?.email == 'penjaga@example.com') {
        box.write('isLoggedIn', true);
        box.write('email', userCredential.user!.email);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PenjagaScreen(username: userCredential.user!.email!),
          ),
        );
      } else {
        box.write('isLoggedIn', true);
        box.write('email', userCredential.user!.email);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DashboardScreen(username: userCredential.user!.email!),
          ),
        );
      }
    } catch (e) {
      // Show error if login fails
      setState(() {
        _errorMessage = 'Login gagal. Periksa kembali email dan password Anda.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('SELAMAT DATANG',
            style: TextStyle(fontSize: 25, color: Colors.white)),
        backgroundColor: const Color(0xFF61AB32),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 300,
                ),
              ),
              SizedBox(height: 50),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('MASUK'),
              ),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },
                child: Text('Belum punya akun? Daftar di sini'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
