import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Penginapan {
  final String nama;
  final String lokasi;
  final String nomorHp;
  final String imageUrl;
  final bool isLocalImage;

  Penginapan(this.nama, this.lokasi, this.nomorHp, this.imageUrl,
      {this.isLocalImage = false});
}

class PenginapanScreen extends StatefulWidget {
  @override
  _PenginapanScreenState createState() => _PenginapanScreenState();
}

class _PenginapanScreenState extends State<PenginapanScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Penginapan',
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('penginapan').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final filteredPenginapanList = snapshot.data!.docs
              .map((doc) => Penginapan(
                    doc['nama'],
                    doc['lokasi'],
                    doc['nomorHp'],
                    doc['imageUrl'],
                    isLocalImage: doc['imageUrl'].startsWith('assets/'),
                  ))
              .where((penginapan) => penginapan.nama
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
              .toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Daftar Penginapan',
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
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: filteredPenginapanList.length,
                  itemBuilder: (context, index) {
                    final penginapan = filteredPenginapanList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailPenginapanPage(penginapan: penginapan),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 2,
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: penginapan.isLocalImage
                                      ? Image.asset(
                                          penginapan.imageUrl,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        )
                                      : Image.network(
                                          penginapan.imageUrl,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        penginapan.nama,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(penginapan.lokasi),
                                      Text('Tel: ${penginapan.nomorHp}'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cari Penginapan'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            decoration:
                InputDecoration(hintText: "Masukkan nama penginapan..."),
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

// Halaman detail penginapan yang menampilkan nomor HP untuk reservasi

class DetailPenginapanPage extends StatelessWidget {
  final Penginapan penginapan;

  DetailPenginapanPage({required this.penginapan});

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
          'Detail Penginapan',
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
              child: penginapan.isLocalImage
                  ? Image.asset(penginapan.imageUrl, fit: BoxFit.cover)
                  : Image.network(penginapan.imageUrl, fit: BoxFit.cover),
            ),
            SizedBox(height: 16.0),
            Text(
              penginapan.nama,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              penginapan.lokasi,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              'Detail Penginapan:',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Untuk Reservasi Kamar silakan hubungi nomor dibawah ini',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  'Hubungi: ${penginapan.nomorHp}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: PenginapanScreen()));
