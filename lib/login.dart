import 'package:flutter/material.dart';
import 'dashboard.dart'; 
import 'register.dart'; 
import 'dashboard_admin.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

    void _login() {
      String username = _userController.text;
      String password = _passwordController.text;

      if (username == 'admin' && password == '5678') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardAdminScreen(username: username)),
        );
      } else if (username == 'user' && password == '1234') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen(username: username)),
        );
      } else {
        setState(() {
          _errorMessage = 'Username atau Password salah';
        });
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('SELAMAT DATANG', style: TextStyle(fontSize: 25, color: Colors.white)),
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
                controller: _userController,
                decoration: InputDecoration(labelText: 'Username'),
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
                    MaterialPageRoute(builder: (context) => RegisterScreen()), // Pindah ke halaman register
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
