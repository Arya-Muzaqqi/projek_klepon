import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'penjaga_lanjutan.dart';
import 'login.dart'; // Pastikan LoginScreen diimpor

class PenjagaScreen extends StatefulWidget {
  final String username;

  const PenjagaScreen({super.key, required this.username});

  @override
  _PenjagaScreenState createState() => _PenjagaScreenState();
}

class _PenjagaScreenState extends State<PenjagaScreen> {
  final TextEditingController _ticketCodeController = TextEditingController();

  // GlobalKey untuk Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _verifyTicket() async {
    String ticketCode = _ticketCodeController.text.trim();

    if (ticketCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Kode tiket tidak boleh kosong"),
      ));
      return;
    }

    try {
      // Mencari tiket berdasarkan kode tiket di Firestore
      QuerySnapshot ticketQuery = await FirebaseFirestore.instance
          .collection('ticket_codes')
          .where('ticket_code', isEqualTo: ticketCode)
          .get();

      if (ticketQuery.docs.isEmpty) {
        // Tiket tidak ditemukan
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Kode tiket tidak valid"),
        ));
      } else {
        // Tiket ditemukan, langsung navigasi ke halaman berikutnya
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TiketLanjutan(ticketCode: ticketCode),
          ),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Terjadi kesalahan, coba lagi"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Menambahkan key ke Scaffold
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Menambahkan UserAccountsDrawerHeader dengan warna ungu muda
            UserAccountsDrawerHeader(
              accountName: Text(widget.username), // Nama pengguna
              accountEmail: Text('penjaga@example.com'), // Email
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/images/profile.jpg'), // Ganti dengan gambar profil
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 159, 9, 161),
              ),
            ),
            ListTile(
              title: Text('Menu Item 1'),
              onTap: () {
                // Handle menu item action
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Menu Item 2'),
              onTap: () {
                // Handle menu item action
                Navigator.pop(context);
              },
            ),
            // Menambahkan Divider sebelum tombol logout
            Divider(),
            // Menambahkan tombol Logout
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Navigasi ke halaman login dan hapus semua rute sebelumnya
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginScreen()), // Mengarahkan ke LoginScreen
                  (route) => false, // Menghapus semua rute sebelumnya
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Loket'),
        centerTitle: true,
        backgroundColor: const Color(0xFF61AB32),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState
                ?.openDrawer(); // Membuka drawer dengan key
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 300,
              ),
              SizedBox(height: 30),
              TextField(
                controller: _ticketCodeController,
                decoration: InputDecoration(
                  labelText: 'Masukkan Kode Tiket',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _verifyTicket,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                ),
                child: Text('Konfirmasi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
