import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dashboard.dart';

class KodeTiketPage extends StatelessWidget {
  final String destination;
  final int totalHarga;
  final int jumlahTiket;

  const KodeTiketPage({
    Key? key,
    required this.destination,
    required this.totalHarga,
    required this.jumlahTiket,
  }) : super(key: key);

  // Generate kode tiket
  String _generateTicketCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return List.generate(8, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  // Simpan data ke Firestore hanya untuk koleksi ticket_codes
  Future<void> _saveTicketToFirestore(String ticketCode) async {
    try {
      // Ambil UID pengguna yang login
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Menyimpan data ke koleksi "ticket_codes" saja
        await FirebaseFirestore.instance.collection('ticket_codes').add({
          'ticket_code': ticketCode,
          'user_id': user.uid, // Simpan user_id untuk referensi
          'status': 'unused', // Status otomatis di-set ke 'unused'
          'destination': destination,
          'total_harga': totalHarga,
          'total_tickets': jumlahTiket,
          'timestamp': FieldValue.serverTimestamp(),
        });

        print("Ticket saved to ticket_codes collection!");
      }
    } catch (e) {
      print("Error saving ticket: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    String ticketCode = _generateTicketCode();
    _saveTicketToFirestore(
        ticketCode); // Simpan data tiket ke Firestore hanya ke ticket_codes

    return Scaffold(
      backgroundColor:
          Color(0xFF61AB32), // Mengubah warna hijau menjadi #61AB32
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.confirmation_num,
                color: Colors.white,
                size: 100,
              ),
              SizedBox(height: 20),
              Text(
                'Kode Tiket: $ticketCode',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'Tujuan: $destination',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'Total Harga: Rp$totalHarga',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'Jumlah Tiket: $jumlahTiket',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DashboardScreen(username: 'Username'),
                    ),
                  );
                },
                child: Text('Kembali ke Beranda'),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xFF61AB32), // Warna hijau di tombol
                    backgroundColor: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
