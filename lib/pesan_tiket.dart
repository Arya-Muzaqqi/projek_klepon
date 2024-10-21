import 'package:flutter/material.dart';

class PesanTiketPage extends StatelessWidget {
  final String destination;
  final int tiketMasuk;

  PesanTiketPage({required this.destination, required this.tiketMasuk});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesan Tiket untuk $destination'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Tiket untuk $destination',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Harga tiket: Rp. $tiketMasuk',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aksi pemesanan tiket bisa diimplementasikan di sini
                Navigator.pop(context); // Kembali setelah pesan tiket
              },
              child: Text('Pesan Sekarang'),
            ),
          ],
        ),
      ),
    );
  }
}
