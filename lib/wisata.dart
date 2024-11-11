import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'detail_wisata.dart'; // Ensure you have the correct import for detail_wisata.dart

class WisataScreen extends StatefulWidget {
  const WisataScreen({super.key});

  @override
  _WisataScreenState createState() => _WisataScreenState();
}

class _WisataScreenState extends State<WisataScreen> {
  String searchQuery = '';
  List<Wisata> wisataList = [];

  @override
  void initState() {
    super.initState();
    fetchWisata();
  }

  Future<void> fetchWisata() async {
    final snapshot = await FirebaseFirestore.instance.collection('wisata').get();
    setState(() {
      wisataList = snapshot.docs.map((doc) {
        final data = doc.data();
        return Wisata(
          data['title'],
          data['location'],
          data['imageUrl'], // This should now be the asset path
          data['harga'],
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredWisataList = wisataList
        .where((wisata) =>
            wisata.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lokasi Wisata',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 68, 255),
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
      backgroundColor: const Color.fromARGB(255, 0, 195, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Daftar Wisata',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8, // Adjusted for mobile view
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: filteredWisataList.length,
                  itemBuilder: (context, index) {
                    final wisata = filteredWisataList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailWisataPage(
                              namaWisata: wisata.title,
                              alamatWisata: wisata.location,
                              tiketMasuk: wisata.harga,
                              imageUrl: wisata.imageUrl,
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  wisata.imageUrl, // Use Image.asset to load images from assets
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.image,
                                        size: 50, color: Colors.grey);
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
                                    wisata.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(wisata.location),
                                  Text(
                                    'Rp. ${wisata.harga}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
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
        ),
      ),
    );
  }

  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cari Wisata'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            decoration:
                const InputDecoration(hintText: "Masukkan nama wisata..."),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tutup'),
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

// Model Wisata
class Wisata {
  final String title;
  final String location;
  final String imageUrl;
  final int harga;

  Wisata(this.title, this.location, this.imageUrl, this.harga);
}
