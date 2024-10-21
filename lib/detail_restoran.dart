import 'package:flutter/material.dart';
import 'pesan_meja.dart';

class DetailRestoranPage extends StatelessWidget {
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
        title: Text('Detail Restoran'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder for restaurant
            Container(
              width: double.infinity,
              height: 200.0,
              color: Colors.grey[300],
              child: Icon(Icons.image, size: 100, color: Colors.grey[700]),
            ),
            SizedBox(height: 16.0),
            
            // Nama Restoran and Alamat Restoran
            Text(
              'Nama Restoran',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Alamat Restoran',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),

            // Menu and Gallery buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Info Menu action
                  },
                  child: Text('Info Menu'),
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

            // Restaurant description placeholder
            Text(
              'Detail informasi mengenai restoran ini. Deskripsi panjang tentang restoran dan jenis makanan yang disediakan...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),

            // Price range and rating
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kisaran Harga:',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Rp. 50.000 - Rp. 200.000', // Replace with dynamic price range
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // Button to make a reservation
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to PesanMejaPage when Reservasi Meja is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PesanRestoranPage(
                        restaurant: 'Nama Restoran',  // Pass the restaurant name
                        priceRange: 'Rp. 50.000 - Rp. 200.000', // Pass the price range
                      ),
                    ),
                  );
                },
                child: Text('Reservasi Meja'),
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
  
  PesanMejaPage({required String restaurant, required String priceRange}) {}
}

void main() => runApp(MaterialApp(home: DetailRestoranPage()));
