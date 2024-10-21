import 'package:flutter/material.dart';
import 'pesan_penginapan.dart'; // Pastikan untuk mengimpor halaman pesan penginapan

class DetailPenginapanPage extends StatelessWidget {
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
        title: Text('Detail Penginapan'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder for penginapan
            Container(
              width: double.infinity,
              height: 200.0,
              color: Colors.grey[300],
              child: Icon(Icons.image, size: 100, color: Colors.grey[700]),
            ),
            SizedBox(height: 16.0),
            
            // Nama Penginapan and Alamat Penginapan
            Text(
              'Nama Penginapan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Alamat Penginapan',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),

            // Info Penginapan and Galeri Penginapan buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Info Penginapan action
                  },
                  child: Text('Info Penginapan'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Galeri Penginapan action
                  },
                  child: Text('Galeri Penginapan'),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // Deskripsi penginapan
            Text(
              'Detail informasi mengenai penginapan ini. Deskripsi panjang tentang penginapan dan fasilitas yang disediakan...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),

            // Kisaran harga dan rating
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kisaran Harga:',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Rp. 200.000 - Rp. 1.000.000', // Ganti dengan kisaran harga dinamis
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // Button untuk melakukan reservasi
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke PesanPenginapanPage saat Beli Tiket ditekan
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PesanPenginapanPage(
                        penginapan: 'Nama Penginapan',  // Ganti dengan nama penginapan
                        hargaReservasi: 500000,         // Ganti dengan harga reservasi
                      ),
                    ),
                  );
                },
                child: Text('Reservasi Sekarang'),
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

void main() => runApp(MaterialApp(home: DetailPenginapanPage()));
