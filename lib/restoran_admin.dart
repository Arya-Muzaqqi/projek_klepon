import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RestoranAdminScreen extends StatefulWidget {
  const RestoranAdminScreen({super.key});

  @override
  _RestoranAdminScreenState createState() => _RestoranAdminScreenState();
}

class _RestoranAdminScreenState extends State<RestoranAdminScreen> {
  List<Restoran> restoranList = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchRestoranData();
  }

  void fetchRestoranData() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('restoran').get();
    setState(() {
      restoranList = snapshot.docs.map((doc) {
        return Restoran.fromDocument(doc);
      }).toList();
    });
  }

  void addRestoran(Restoran restoran) async {
    await FirebaseFirestore.instance.collection('restoran').add({
      'nama': restoran.nama,
      'lokasi': restoran.lokasi,
      'nomorHp': restoran.nomorHp,
      'imageUrl': restoran.imageUrl,
      'deskripsi': restoran.deskripsi,
    });
    fetchRestoranData(); // Refresh the list
  }

  void deleteRestoran(String id) async {
    await FirebaseFirestore.instance.collection('restoran').doc(id).delete();
    fetchRestoranData(); // Refresh the list
  }

  @override
  Widget build(BuildContext context) {
    final filteredRestoranList = restoranList
        .where((restoran) =>
            restoran.nama.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Restoran (Admin)',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Daftar Restoran (Admin)',
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
              itemCount: filteredRestoranList.length,
              itemBuilder: (context, index) {
                final restoran = filteredRestoranList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailRestoranAdminPage(
                          restoran: restoran,
                          onUpdate: (updatedRestoran) {
                            setState(() {
                              restoranList[index] = updatedRestoran;
                            });
                          },
                        ),
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
                              child: Image.network(
                                restoran.imageUrl,
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
                                    restoran.nama,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(restoran.lokasi),
                                  Text('Tel: ${restoran.nomorHp}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: IconButton(
                            icon: Icon(Icons.edit, color: Colors.white),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailRestoranAdminPage(
                                    restoran: restoran,
                                    onUpdate: (updatedRestoran) {
                                      setState(() {
                                        restoranList[index] = updatedRestoran;
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          left: 8,
                          top: 8,
                          child: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              showDeleteConfirmationDialog(restoran.id);
                            },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddRestoranDialog(context);
        },
        child: const Icon(Icons.add),
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

  void showAddRestoranDialog(BuildContext context) {
    final namaController = TextEditingController();
    final lokasiController = TextEditingController();
    final nomorHpController = TextEditingController();
    final imageUrlController = TextEditingController();
    final deskripsiController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Restoran'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namaController,
                decoration: InputDecoration(labelText: 'Nama Restoran'),
              ),
              TextField(
                controller: lokasiController,
                decoration: InputDecoration(labelText: 'Lokasi Restoran'),
              ),
              TextField(
                controller: nomorHpController,
                decoration: InputDecoration(labelText: 'Nomor Telepon'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: imageUrlController,
                decoration: InputDecoration(labelText: 'URL Gambar'),
              ),
              TextField(
                controller: deskripsiController,
                decoration: InputDecoration(labelText: 'Deskripsi Restoran'),
                maxLines: 3,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Tambah'),
              onPressed: () {
                final newRestoran = Restoran(
                  namaController.text,
                  lokasiController.text,
                  nomorHpController.text,
                  imageUrlController.text,
                  deskripsiController.text,
                );
                addRestoran(newRestoran);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showDeleteConfirmationDialog(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus Restoran'),
          content: Text('Apakah Anda yakin ingin menghapus restoran ini?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () {
                deleteRestoran(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class DetailRestoranAdminPage extends StatefulWidget {
  final Restoran restoran;
  final Function(Restoran) onUpdate;

  const DetailRestoranAdminPage({super.key, required this.restoran, required this.onUpdate});

  @override
  _DetailRestoranAdminPageState createState() =>
      _DetailRestoranAdminPageState();
}

class _DetailRestoranAdminPageState extends State<DetailRestoranAdminPage> {
  late TextEditingController namaController;
  late TextEditingController lokasiController;
  late TextEditingController nomorHpController;
  late TextEditingController imageUrlController;
  late TextEditingController deskripsiController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.restoran.nama);
    lokasiController = TextEditingController(text: widget.restoran.lokasi);
    nomorHpController = TextEditingController(text: widget.restoran.nomorHp);
    imageUrlController = TextEditingController(text: widget.restoran.imageUrl);
    deskripsiController =
        TextEditingController(text: widget.restoran.deskripsi);
  }

  @override
  void dispose() {
    namaController.dispose();
    lokasiController.dispose();
    nomorHpController.dispose();
    imageUrlController.dispose();
    deskripsiController.dispose();
    super.dispose();
  }

  void updateRestoran() {
    final updatedRestoran = Restoran(
      namaController.text,
      lokasiController.text,
      nomorHpController.text,
      imageUrlController.text,
      deskripsiController.text,
    );
    FirebaseFirestore.instance
        .collection('restoran')
        .doc(widget.restoran.id)
        .update({
      'nama': updatedRestoran.nama,
      'lokasi': updatedRestoran.lokasi,
      'nomorHp': updatedRestoran.nomorHp,
      'imageUrl': updatedRestoran.imageUrl,
      'deskripsi': updatedRestoran.deskripsi,
    });
    widget.onUpdate(updatedRestoran);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Restoran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Nama Restoran'),
            ),
            TextField(
              controller: lokasiController,
              decoration: InputDecoration(labelText: 'Lokasi Restoran'),
            ),
            TextField(
              controller: nomorHpController,
              decoration: InputDecoration(labelText: 'Nomor Telepon'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(labelText: 'URL Gambar'),
            ),
            TextField(
              controller: deskripsiController,
              decoration: InputDecoration(labelText: 'Deskripsi Restoran'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: updateRestoran,
                child: Text('Simpan Perubahan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Restoran {
  String id;
  String nama;
  String lokasi;
  String nomorHp;
  String imageUrl;
  String deskripsi;

  Restoran(this.nama, this.lokasi, this.nomorHp, this.imageUrl, this.deskripsi)
      : id = '';

  Restoran.fromDocument(DocumentSnapshot doc)
      : id = doc.id,
        nama = doc['nama'],
        lokasi = doc['lokasi'],
        nomorHp = doc['nomorHp'],
        imageUrl = doc['imageUrl'],
        deskripsi = doc['deskripsi'];
}
