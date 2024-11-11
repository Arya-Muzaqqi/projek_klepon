import 'package:flutter/material.dart';
import 'dart:math';
import 'dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    return List.generate(12, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  // Simpan data ke Firestore
  Future<void> _saveTicketToFirestore(String ticketCode) async {
    try {
      // Menyimpan kode tiket ke koleksi "tiket" di Firestore
      await FirebaseFirestore.instance.collection('ticket_codes').add({
        'ticket_code': ticketCode,
        'destination': destination,
        'total_harga': totalHarga,
        'total_tickets': jumlahTiket,
      });
    } catch (e) {
      print("Error saving ticket: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    String ticketCode = _generateTicketCode();
    _saveTicketToFirestore(ticketCode); // Simpan data tiket ke Firestore

    return Scaffold(
      backgroundColor: Colors.green.shade400,
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
                    foregroundColor: Colors.green.shade700,
                    backgroundColor: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
