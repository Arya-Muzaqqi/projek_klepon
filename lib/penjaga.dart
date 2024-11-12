import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'penjaga_lanjutan.dart';
import 'login.dart';

class PenjagaScreen extends StatefulWidget {
  final String username;

  const PenjagaScreen({Key? key, required this.username}) : super(key: key);

  @override
  _PenjagaScreenState createState() => _PenjagaScreenState();
}

class _PenjagaScreenState extends State<PenjagaScreen> {
  TextEditingController _ticketCodeController = TextEditingController();

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
        var ticketDoc = ticketQuery.docs[0];
        String status = ticketDoc['status'];

        if (status == 'used') {
          // Jika tiket sudah digunakan, tampilkan pesan
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Tiket sudah digunakan"),
          ));
        } else {
          // Tiket valid dan belum digunakan, ubah status menjadi 'used'
          await FirebaseFirestore.instance
              .collection('ticket_codes')
              .doc(ticketDoc.id)
              .update({'status': 'used'}); // Mengubah status tiket

          // Menavigasi ke halaman berikutnya
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TiketLanjutan(ticketCode: ticketCode),
            ),
          );
        }
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Terjadi kesalahan, coba lagi"),
      ));
    }
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false, // Menghapus seluruh riwayat halaman
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Loket',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF61AB32),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
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
      ),
    );
  }
}
