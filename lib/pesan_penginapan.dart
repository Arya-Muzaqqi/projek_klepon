import 'package:flutter/material.dart';

class PesanPenginapanPage extends StatelessWidget {
  final String penginapan;
  final int hargaReservasi;

  PesanPenginapanPage({required this.penginapan, required this.hargaReservasi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesan Tempat di $penginapan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Pesan Tempat di $penginapan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Biaya reservasi: Rp. $hargaReservasi',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aksi pemesanan penginapan bisa diimplementasikan di sini
                Navigator.pop(context); // Kembali setelah pesan tempat
              },
              child: Text('Pesan Sekarang'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: PesanPenginapanPage(penginapan: 'Contoh Penginapan', hargaReservasi: 500000)));
