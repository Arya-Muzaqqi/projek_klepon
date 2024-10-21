import 'package:flutter/material.dart';
import 'pesan_tiket.dart';

class DetailWisataPage extends StatelessWidget {
  final String namaWisata;
  final String alamatWisata;
  final int tiketMasuk;

  // Constructor untuk menerima data dari halaman sebelumnya
  DetailWisataPage({
    required this.namaWisata,
    required this.alamatWisata,
    required this.tiketMasuk,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(namaWisata), // Menggunakan nama wisata dinamis
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200.0,
              color: Colors.grey[300],
              child: Icon(Icons.image, size: 100, color: Colors.grey[700]), // Placeholder untuk gambar
            ),
            SizedBox(height: 16.0),
            
            // Nama Wisata and Alamat Wisata
            Text(
              namaWisata, // Menampilkan nama wisata yang diterima
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              alamatWisata, // Menampilkan alamat wisata yang diterima
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),

            // Info Wisata and Galeri Wisata buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Aksi untuk Info Wisata
                  },
                  child: Text('Info Wisata'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Aksi untuk Galeri Wisata
                  },
                  child: Text('Galeri Wisata'),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // Info Wisata text (placeholder)
            Text(
              'Detail informasi mengenai wisata ini. Deskripsi panjang tentang wisata yang diulas...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),

            // Ticket and price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tiket Masuk:',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Rp. $tiketMasuk', // Menampilkan harga tiket dinamis
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // Button to buy a ticket
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke PesanTiketPage saat tombol "Beli Tiket" ditekan
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PesanTiketPage(
                        destination: namaWisata,  // Mengoper nama wisata
                        tiketMasuk: tiketMasuk,   // Mengoper harga tiket
                      ),
                    ),
                  );
                },
                child: Text('Beli Tiket'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
