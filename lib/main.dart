import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login & Register Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(), // Layar pertama adalah login
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    // Langsung arahkan pengguna ke MainMenuScreen tanpa validasi
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainMenuScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('SELAMAT DATANG'),
      ),
      body: Padding(
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
              onPressed: _login, // Langsung arahkan ke MainMenuScreen
              child: Text('MASUK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text('Belum punya akun? Daftar di sini'),
            ),
          ],
        ),
      ),
    );
  }
}

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

  void _showWarningDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Peringatan'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DAFTAR'),
        centerTitle: true,
      ),
      body: Padding(
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
              onPressed: () {
                if (_nameController.text.isEmpty ||
                    _emailController.text.isEmpty ||
                    _noHPController.text.isEmpty ||
                    _passwordController.text.isEmpty ||
                    _confirmPasswordController.text.isEmpty) {
                  _showWarningDialog("Harap isi semua data");
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }
              },
              child: Text('Daftar'),
            ),
          ],
        ),
      ),
    );
  }
}

// Ini adalah tampilan menu utama setelah login
class MainMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Destinasi Wisata'),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari di sini',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Text(
              'Semua Wisata',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              height: 150,
              width: double.infinity,
              color: Colors.grey[300],
              child: Icon(Icons.image, size: 100, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.travel_explore, size: 50),
                    Text('Wisata', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.hotel, size: 50),
                    Text('Penginapan', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.restaurant, size: 50),
                    Text('Restoran', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Ini adalah drawer dengan menu dan tombol logout
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Username"),
            accountEmail: Text("username@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 50),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profil'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.travel_explore),
            title: Text('Daftar Wisata'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.hotel),
            title: Text('Daftar Penginapan'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.restaurant),
            title: Text('Daftar Restoran'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              // Arahkan ke halaman login dan hapus semua halaman sebelumnya dari tumpukan
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false, // Hapus semua halaman sebelumnya
              );
            },
          ),
        ],
      ),
    );
  }
}
