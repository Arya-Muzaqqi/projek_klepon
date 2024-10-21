import 'package:flutter/material.dart';
import 'pesan_tiket.dart';

class RestoranScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lokasi Restoran'),
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
              'Daftar Restoran',
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
                      // Navigate to DetailRestoranPage when an item is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailRestoranPage(
                            namaRestoran: 'Restoran ${index + 1}', // Pass dynamic data
                            alamatRestoran: 'Alamat Restoran ${index + 1}',
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
                          Icon(Icons.restaurant, size: 50, color: Colors.grey),
                          SizedBox(height: 8),
                          Text(
                            'Restoran ${index + 1}', // Dynamic text for each image
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

// Create DetailRestoranPage with dynamic data
class DetailRestoranPage extends StatelessWidget {
  final String namaRestoran;
  final String alamatRestoran;
  final int tiketMasuk;

  DetailRestoranPage({
    required this.namaRestoran,
    required this.alamatRestoran,
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
        title: Text(namaRestoran),
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
              child: Icon(Icons.restaurant, size: 100, color: Colors.grey[700]),
            ),
            SizedBox(height: 16.0),

            // Nama Restoran and Alamat Restoran
            Text(
              namaRestoran,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              alamatRestoran,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),

            // Info Restoran and Galeri Restoran buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Info Restoran action
                  },
                  child: Text('Info Restoran'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Galeri Restoran action
                  },
                  child: Text('Galeri Restoran'),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // Info Restoran text (as placeholder)
            Text(
              'Detail informasi mengenai restoran ini. Deskripsi panjang tentang restoran yang diulas...',
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
                  // Navigate to PesanTiketPage when "Beli Tiket" button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PesanTiketPage(
                        destination: namaRestoran, // Send namaRestoran
                        tiketMasuk: tiketMasuk,  // Send tiketMasuk
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

void main() => runApp(MaterialApp(home: RestoranScreen()));
