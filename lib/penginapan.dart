import 'package:flutter/material.dart';
import 'pesan_tiket.dart';

class PenginapanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lokasi Penginapan'),
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
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari di sini',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Text(
              'Daftar Penginapan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: List.generate(6, (index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to DetailPenginapanPage when an item is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPenginapanPage(
                            namaPenginapan: 'Penginapan ${index + 1}', // Pass dynamic data
                            alamatPenginapan: 'Alamat Penginapan ${index + 1}',
                            tiketMasuk: 50000 + (index * 5000), // Example ticket price
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image, size: 50, color: Colors.grey),
                          SizedBox(height: 8),
                          Text(
                            'Penginapan ${index + 1}', // Dynamic text for each image
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Create DetailPenginapanPage with dynamic data
class DetailPenginapanPage extends StatelessWidget {
  final String namaPenginapan;
  final String alamatPenginapan;
  final int tiketMasuk;

  DetailPenginapanPage({
    required this.namaPenginapan,
    required this.alamatPenginapan,
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
        title: Text(namaPenginapan),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(
              width: double.infinity,
              height: 200.0,
              color: Colors.grey[300],
              child: Icon(Icons.image, size: 100, color: Colors.grey[700]),
            ),
            SizedBox(height: 16.0),

            // Nama Penginapan and Alamat Penginapan
            Text(
              namaPenginapan,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              alamatPenginapan,
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

            // Info Penginapan text (as placeholder)
            Text(
              'Detail informasi mengenai Penginapan ini. Deskripsi panjang tentang penginapan yang diulas...',
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
                  'Rp. $tiketMasuk', // Dynamic price
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // Button to buy a ticket
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke PesanTiketPage ketika tombol "Beli Tiket" ditekan
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PesanTiketPage(
                        destination: namaPenginapan, // Mengirim namaPenginapan
                        tiketMasuk: tiketMasuk,  // Mengirim tiketMasuk
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

void main() => runApp(MaterialApp(home: PenginapanScreen()));
