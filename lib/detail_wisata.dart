import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pesan_tiket.dart';

class DetailWisataPage extends StatelessWidget {
  final String namaWisata;
  final String alamatWisata;
  final int tiketMasuk;
  final String imageUrl; // Variabel untuk URL gambar

  const DetailWisataPage({
    super.key,
    required this.namaWisata,
    required this.alamatWisata,
    required this.tiketMasuk,
    required this.imageUrl, // Menerima URL gambar dari API
  });

  Future<Map<String, dynamic>> fetchWisataDetails() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('wisata')
        .where('title', isEqualTo: namaWisata)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.data();
    } else {
      throw Exception('Wisata tidak ditemukan');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          namaWisata,
          style:
              TextStyle(color: Colors.white), // Warna teks judul menjadi putih
        ),
        backgroundColor: Color(0xFF61AB32), // Background AppBar hijau
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menampilkan gambar dari assets
            SizedBox(
              width: double.infinity,
              height:
                  MediaQuery.of(context).size.height * 0.3, // Responsive height
              child: Image.asset(
                imageUrl, // Menggunakan URL gambar yang diambil dari parameter
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              namaWisata,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              alamatWisata,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return FutureBuilder<Map<String, dynamic>>(
                          future: fetchWisataDetails(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return AlertDialog(
                                title: Text('Loading...'),
                                content: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text('Error: ${snapshot.error}'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Tutup'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            } else {
                              String deskripsi = snapshot.data?['deskripsi'] ??
                                  'Deskripsi tidak tersedia.';
                              return AlertDialog(
                                title: Text('Deskripsi Wisata'),
                                content: Text(deskripsi),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Tutup'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF61AB32), // Teks tombol putih
                  ),
                  child: Text('Info Wisata'),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return FutureBuilder<Map<String, dynamic>>(
                          future: fetchWisataDetails(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return AlertDialog(
                                title: Text('Loading...'),
                                content: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text('Error: ${snapshot.error}'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Tutup'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            } else {
                              List<dynamic> galeri =
                                  snapshot.data?['galeri'] ?? [];
                              return AlertDialog(
                                title: Text('Galeri Wisata'),
                                content: SizedBox(
                                  width: double.maxFinite,
                                  height: MediaQuery.of(context).size.height *
                                      0.4, // Responsive height for gallery
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.0,
                                      crossAxisSpacing: 8.0,
                                      mainAxisSpacing: 8.0,
                                    ),
                                    itemCount: galeri.length,
                                    itemBuilder: (context, index) {
                                      // Cek apakah URL gambar berasal dari assets atau network
                                      String imagePath = galeri[index];
                                      if (imagePath.startsWith('assets/')) {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            imagePath,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      } else {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            imagePath,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Tutup'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF61AB32), // Teks tombol putih
                  ),
                  child: Text('Galeri Wisata'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Detail informasi mengenai wisata ini bisa dicek di info wisata.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tiket Masuk:',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Rp. $tiketMasuk',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PesanTiketPage(
                        destination: namaWisata,
                        tiketMasuk: tiketMasuk,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF61AB32), // Tombol hijau
                  foregroundColor: Colors.white, // Teks putih
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text('Pesan Tiket'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
