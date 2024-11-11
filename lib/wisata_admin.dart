import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// Halaman utama admin untuk mengelola lokasi wisata
class WisataAdminScreen extends StatefulWidget {
  const WisataAdminScreen({super.key});

  @override
  _WisataAdminScreenState createState() => _WisataAdminScreenState();
}

class _WisataAdminScreenState extends State<WisataAdminScreen> {
  String searchQuery = '';
  final CollectionReference wisataCollection =
      FirebaseFirestore.instance.collection('wisata');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Wisata (Admin)',
            style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 0, 68, 255),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              showAddWisataDialog(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearchDialog(context);
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 0, 195, 255),
      body: StreamBuilder<QuerySnapshot>(
        stream: wisataCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          }

          final filteredWisataList = snapshot.data!.docs.where((doc) {
            return doc['title']
                .toString()
                .toLowerCase()
                .contains(searchQuery.toLowerCase());
          }).toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Daftar Wisata (Admin)',
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
                  itemCount: filteredWisataList.length,
                  itemBuilder: (context, index) {
                    final doc = filteredWisataList[index];
                    final data = doc.data() as Map<String, dynamic>;

                    return GestureDetector(
                      onTap: () {
                        // Navigasi ke halaman edit dengan mengirim data yang diperlukan
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditWisataPage(
                              docId: doc.id,
                              title: data['title'],
                              location: data['location'],
                              harga: data['harga'],
                              imageUrl: data['imageUrl'],
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
                              child: Image.network(
                                data['imageUrl'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['title'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(data['location']),
                                  Text('Rp. ${data['harga']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () => deleteWisata(doc.id),
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
          );
        },
      ),
    );
  }

  // Dialog untuk mencari wisata
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

  // Dialog untuk menambahkan wisata baru
  void showAddWisataDialog(BuildContext context) {
    String title = '';
    String location = '';
    String harga = '';
    File? imageFile;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tambah Wisata Baru'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => title = value,
                decoration: const InputDecoration(labelText: 'Nama Wisata'),
              ),
              TextField(
                onChanged: (value) => location = value,
                decoration: const InputDecoration(labelText: 'Lokasi Wisata'),
              ),
              TextField(
                onChanged: (value) => harga = value,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Harga Tiket'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    imageFile = File(pickedFile.path);
                  }
                },
                child: const Text('Pilih Gambar'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Tambah'),
              onPressed: () async {
                if (title.isNotEmpty &&
                    location.isNotEmpty &&
                    harga.isNotEmpty &&
                    imageFile != null) {
                  final storageRef = FirebaseStorage.instance
                      .ref()
                      .child('wisata_images/${DateTime.now().toString()}.jpg');
                  await storageRef.putFile(imageFile!);
                  final imageUrl = await storageRef.getDownloadURL();

                  await wisataCollection.add({
                    'title': title,
                    'location': location,
                    'harga': int.parse(harga),
                    'imageUrl': imageUrl,
                  });

                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Menghapus wisata berdasarkan ID dengan konfirmasi
  Future<void> deleteWisata(String id) async {
    // Tampilkan dialog konfirmasi
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: const Text('Apakah Anda yakin ingin menghapus wisata ini?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    // Jika pengguna mengonfirmasi penghapusan
    if (shouldDelete == true) {
      await wisataCollection.doc(id).delete();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Wisata dihapus')));
    }
  }
}

// Halaman untuk mengedit wisata
class EditWisataPage extends StatelessWidget {
  final String docId;
  final String title;
  final String location;
  final int harga;
  final String imageUrl;

  const EditWisataPage({super.key, 
    required this.docId,
    required this.title,
    required this.location,
    required this.harga,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    String updatedTitle = title;
    String updatedLocation = location;
    String updatedHarga = harga.toString();
    File? updatedImageFile;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Wisata'),
        backgroundColor: const Color.fromARGB(255, 0, 68, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => updatedTitle = value,
              decoration: const InputDecoration(labelText: 'Nama Wisata'),
              controller: TextEditingController(text: title),
            ),
            TextField(
              onChanged: (value) => updatedLocation = value,
              decoration: const InputDecoration(labelText: 'Lokasi Wisata'),
              controller: TextEditingController(text: location),
            ),
            TextField(
              onChanged: (value) => updatedHarga = value,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Harga Tiket'),
              controller: TextEditingController(text: harga.toString()),
            ),
            ElevatedButton(
              onPressed: () async {
                final picker = ImagePicker();
                final pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  updatedImageFile = File(pickedFile.path);
                }
              },
              child: const Text('Pilih Gambar'),
            ),
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> updatedData = {
                  'title': updatedTitle,
                  'location': updatedLocation,
                  'harga': int.parse(updatedHarga),
                };

                if (updatedImageFile != null) {
                  final storageRef = FirebaseStorage.instance
                      .ref()
                      .child('wisata_images/${DateTime.now().toString()}.jpg');
                  await storageRef.putFile(updatedImageFile!);
                  final updatedImageUrl = await storageRef.getDownloadURL();
                  updatedData['imageUrl'] = updatedImageUrl;
                }

                await FirebaseFirestore.instance
                    .collection('wisata')
                    .doc(docId)
                    .update(updatedData);
                Navigator.pop(context);
              },
              child: const Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}
