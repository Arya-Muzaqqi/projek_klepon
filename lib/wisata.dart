import 'package:flutter/material.dart';
import 'pesan_tiket.dart';

class WisataScreen extends StatefulWidget {
  @override
  _WisataScreenState createState() => _WisataScreenState();
}

class _WisataScreenState extends State<WisataScreen> {
  String searchQuery = ''; // Variabel untuk menyimpan query pencarian

  @override
  Widget build(BuildContext context) {
    // Filter daftar wisata berdasarkan query pencarian
    final filteredWisataList = wisataList
        .where((wisata) =>
            wisata.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Wisata', style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 0, 68, 255),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back , color : Colors.white),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color : Colors.white),
            onPressed: () {
              showSearchDialog(context);
            },
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 0, 195, 255),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Daftar Wisata',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Jumlah kolom
                childAspectRatio: 1, // Rasio tampilan grid
                crossAxisSpacing: 8, // Jarak antar kolom
                mainAxisSpacing: 8, // Jarak antar baris
              ),
              itemCount: filteredWisataList.length, // Jumlah item yang difilter
              itemBuilder: (context, index) {
                final wisata = filteredWisataList[index];
                return GestureDetector(
                  onTap: () {
                    // Navigasi ke halaman detail wisata saat item ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailWisataPage(
                          namaWisata: wisata.title,
                          alamatWisata: wisata.location,
                          tiketMasuk: wisata.harga, // Mengambil harga dari objek wisata
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.asset(
                            wisata.imageUrl, // Menggunakan gambar dari assets
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                wisata.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(wisata.location), // Menampilkan lokasi dari objek wisata
                              Text('Rp. ${wisata.harga}', // Menampilkan harga dari objek wisata
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan dialog pencarian
  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cari Wisata'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value; // Update query pencarian
              });
            },
            decoration: InputDecoration(hintText: "Masukkan nama wisata..."),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
            ),
          ],
        );
      },
    );
  }
}

// Class DetailWisataPage tetap sama seperti sebelumnya
class DetailWisataPage extends StatelessWidget {
  final String namaWisata;
  final String alamatWisata;
  final int tiketMasuk;

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
        title: Text(namaWisata),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder untuk gambar
            Container(
              width: double.infinity,
              height: 200.0,
              color: Colors.grey[300],
              child: Icon(Icons.image, size: 100, color: Colors.grey[700]),
            ),
            SizedBox(height: 16.0),
            Text(
              namaWisata,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    // Aksi tombol Info Wisata
                  },
                  child: Text('Info Wisata'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Aksi tombol Galeri Wisata
                  },
                  child: Text('Galeri Wisata'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Detail informasi mengenai wisata ini. Deskripsi panjang tentang wisata yang diulas...',
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
                  'Rp. $tiketMasuk', // Harga tiket dinamis
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

// Daftar wisata (menggunakan gambar dari assets)
class Wisata {
  final String title;
  final String location;
  final String imageUrl;
  final int harga;

  Wisata(this.title, this.location, this.imageUrl, this.harga);
}

final List<Wisata> wisataList = [
  Wisata('Umbul Sigedang', 'Pusur, Karanglo, Polanharjo', 'assets/images/sigedang.png', 10000),
  Wisata('Umbul Manten', 'Boto, Wunut, Tulung', 'assets/images/manten.png', 10000),
  Wisata('Umbul Nilo', 'Daleman, Tulung', 'assets/images/nilo.png', 8000),
  Wisata('Umbul Ponggok', 'Jeblogan, Ponggok, Polanharjo', 'assets/images/ponggok.png', 10000),
  Wisata('Candi Plaosan', 'Plaosan Lor, Bugisan, Prambanan', 'assets/images/candi.png', 5000),
  Wisata('Bukit Cinta', 'Gn. Gajah, Bayat', 'assets/images/bukit.png', 50000),
];
