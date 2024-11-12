import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Restoran {
  final String nama;
  final String lokasi;
  final String nomorHp;
  final String imageUrl; // Nama file gambar di dalam assets
  final String deskripsi; // Tambahan deskripsi

  Restoran(this.nama, this.lokasi, this.nomorHp, this.imageUrl, this.deskripsi);
}

class RestoranScreen extends StatefulWidget {
  @override
  _RestoranScreenState createState() => _RestoranScreenState();
}

class _RestoranScreenState extends State<RestoranScreen> {
  List<Restoran> restoranList = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchRestoranData();
  }

  Future<void> fetchRestoranData() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('restoran').get();
    setState(() {
      restoranList = snapshot.docs.map((doc) {
        return Restoran(
          doc['nama'],
          doc['lokasi'],
          doc['nomorHp'],
          doc['imageUrl'], // Mengambil nama file gambar
          doc['deskripsi'], // Mengambil deskripsi dari Firestore
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredRestoranList = restoranList
        .where((restoran) =>
            restoran.nama.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Restoran',
            style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 0, 68, 255),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearchDialog(context);
            },
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 0, 195, 255),
      body: restoranList.isEmpty
          ? Center(child: CircularProgressIndicator()) // Indikator loading
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Daftar Restoran',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: filteredRestoranList.length,
                    itemBuilder: (context, index) {
                      final restoran = filteredRestoranList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailRestoranPage(restoran: restoran),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipOval(
                                  child: Image.asset(
                                    restoran.imageUrl, // Menggunakan imageUrl
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                          child:
                                              Text('Gambar tidak ditemukan'));
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      restoran.nama,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(restoran.lokasi),
                                    Text('Tel: ${restoran.nomorHp}'),
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

  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cari Restoran'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            decoration: InputDecoration(hintText: "Masukkan nama restoran..."),
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
      },
    );
  }
}

class DetailRestoranPage extends StatelessWidget {
  final Restoran restoran;

  DetailRestoranPage({required this.restoran});

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
          'Detail Restoran',
          style:
              TextStyle(color: Colors.white), // Ubah warna teks menjadi putih
        ),
        backgroundColor: Color(0xFF61AB32), // Warna hijau pada AppBar
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
              child: Image.asset(restoran.imageUrl, fit: BoxFit.cover),
            ),
            SizedBox(height: 16.0),
            Text(
              restoran.nama,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              restoran.lokasi,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  'Hubungi: ${restoran.nomorHp}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              restoran.deskripsi,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: RestoranScreen()));
