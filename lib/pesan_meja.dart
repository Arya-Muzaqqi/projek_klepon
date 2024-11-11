import 'package:flutter/material.dart';

class PesanRestoranPage extends StatelessWidget {
  final String restaurant;
  final String priceRange;

  const PesanRestoranPage({super.key, required this.restaurant, required this.priceRange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesan Tempat di $restaurant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Pesan Tempat di $restaurant',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Kisaran Harga: $priceRange',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aksi pemesanan restoran bisa diimplementasikan di sini
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
