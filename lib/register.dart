import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _noHPController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String _errorMessage = '';

  // Fungsi untuk melakukan pendaftaran ke Firebase
  void _register() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String noHP = _noHPController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // Validasi input
    if (name.isEmpty || email.isEmpty || noHP.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        _errorMessage = 'Harap isi semua data';
      });
    } else if (password != confirmPassword) {
      setState(() {
        _errorMessage = 'Password dan Konfirmasi Password tidak cocok';
      });
    } else {
      try {
        // Daftarkan pengguna menggunakan Firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Setelah berhasil, arahkan pengguna ke halaman login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } on FirebaseAuthException catch (e) {
        // Tangani error yang terjadi saat mendaftar
        if (e.code == 'weak-password') {
          setState(() {
            _errorMessage = 'Password terlalu lemah.';
          });
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            _errorMessage = 'Email sudah digunakan.';
          });
        } else {
          setState(() {
            _errorMessage = 'Terjadi kesalahan. Coba lagi nanti.';
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'Terjadi kesalahan. Coba lagi nanti.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DAFTAR', style: TextStyle(fontSize: 25, color: Colors.white)),
        backgroundColor: const Color(0xFF61AB32),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 250,
                ),
              ),
              SizedBox(height: 50),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama Lengkap'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _noHPController,
                decoration: InputDecoration(labelText: 'No Handphone'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Konfirmasi Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: Text('Daftar'),
              ),
              SizedBox(height: 10),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
