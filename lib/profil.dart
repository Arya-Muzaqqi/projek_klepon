import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dashboard.dart';

class ProfilScreen extends StatefulWidget {
  final String username;

  ProfilScreen({required this.username});

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  String? _gender;
  String _name = '';
  String _email = '';
  String _noHp = '';
  String _alamat = '';

  // TextEditingController untuk setiap field
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _noHpController;
  late TextEditingController _alamatController;

  Future<void> _loadUserProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            _name = userDoc['name'] ?? '';
            _email = userDoc['email'] ?? '';
            _noHp = userDoc['NoHp'] ?? '';
            _alamat = userDoc['alamat'] ?? '';
            _gender = userDoc['gender'] ?? '';

            // Set data awal di setiap TextEditingController
            _nameController.text = _name;
            _emailController.text = _email;
            _noHpController.text = _noHp;
            _alamatController.text = _alamat;
          });
        }
      }
    } catch (e) {
      print("Gagal memuat data profil: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _noHpController = TextEditingController();
    _alamatController = TextEditingController();
    _loadUserProfile(); // Memuat profil saat initState
  }

  void _updateUserProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Perbarui data profil di Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'name': _nameController.text,
          'NoHp': _noHpController.text,
          'alamat': _alamatController.text,
          'gender': _gender,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profil berhasil diperbarui')),
        );
      }
    } catch (e) {
      print("Gagal memperbarui data profil: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui profil')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, size: 50, color: Colors.grey),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text('Jenis Kelamin'),
            Row(
              children: [
                Radio<String>(
                  value: 'Laki-laki',
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
                Text('Laki-laki'),
                Radio<String>(
                  value: 'Perempuan',
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
                Text('Perempuan'),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _alamatController,
              decoration: InputDecoration(
                labelText: 'Alamat',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _noHpController,
              decoration: InputDecoration(
                labelText: 'Nomor Handphone',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              readOnly: true, // Membuat email tidak bisa diedit
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _updateUserProfile,
                child: Text('Simpan'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DashboardScreen(username: widget.username),
                    ),
                  );
                },
                child: Text('Menu Utama'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
