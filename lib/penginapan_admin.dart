import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PenginapanAdminScreen extends StatefulWidget {
  const PenginapanAdminScreen({super.key});

  @override
  _PenginapanAdminScreenState createState() => _PenginapanAdminScreenState();
}

class _PenginapanAdminScreenState extends State<PenginapanAdminScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String searchQuery = '';
  List<Penginapan> penginapanList = [];

  @override
  void initState() {
    super.initState();
    fetchPenginapanData();
  }

  void fetchPenginapanData() async {
    final snapshot = await _firestore.collection('penginapan').get();
    setState(() {
      penginapanList = snapshot.docs.map((doc) {
        return Penginapan(
          doc['nama'],
          doc['lokasi'],
          doc['nomorHp'],
          doc['imageUrl'],
        );
      }).toList();
    });
  }

  void addPenginapan() async {
    final newPenginapan = await showDialog<Penginapan>(
      context: context,
      builder: (context) {
        return AddPenginapanDialog();
      },
    );
    if (newPenginapan != null) {
      await _firestore.collection('penginapan').doc(newPenginapan.nama).set({
        'nama': newPenginapan.nama,
        'lokasi': newPenginapan.lokasi,
        'nomorHp': newPenginapan.nomorHp,
        'imageUrl': newPenginapan.imageUrl,
      });
      fetchPenginapanData(); // Refresh data after adding
    }
  }

  void deletePenginapan(String nama) async {
    // Tampilkan dialog konfirmasi sebelum menghapus
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content:
              Text('Apakah Anda yakin ingin menghapus penginapan "$nama"?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () async {
                await _firestore.collection('penginapan').doc(nama).delete();
                fetchPenginapanData(); // Refresh data setelah menghapus
                Navigator.of(context).pop(); // Menutup dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredPenginapanList = penginapanList
        .where((penginapan) =>
            penginapan.nama.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Penginapan (Admin)',
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
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: addPenginapan,
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
                  'Daftar Penginapan (Admin)',
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
                        builder: (context) => DetailPenginapanAdminPage(
                          penginapan: penginapan,
                          onUpdate: (updatedPenginapan) {
                            setState(() {
                              penginapanList[index] = updatedPenginapan;
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
                              child: Image.asset(
                                penginapan.imageUrl,
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
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.white),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailPenginapanAdminPage(
                                        penginapan: penginapan,
                                        onUpdate: (updatedPenginapan) {
                                          setState(() {
                                            penginapanList[index] =
                                                updatedPenginapan;
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  deletePenginapan(penginapan.nama);
                                },
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

class DetailPenginapanAdminPage extends StatefulWidget {
  final Penginapan penginapan;
  final Function(Penginapan) onUpdate;

  const DetailPenginapanAdminPage({super.key, required this.penginapan, required this.onUpdate});

  @override
  _DetailPenginapanAdminPageState createState() =>
      _DetailPenginapanAdminPageState();
}

class _DetailPenginapanAdminPageState extends State<DetailPenginapanAdminPage> {
  late TextEditingController namaController;
  late TextEditingController lokasiController;
  late TextEditingController nomorHpController;
  late TextEditingController imageUrlController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.penginapan.nama);
    lokasiController = TextEditingController(text: widget.penginapan.lokasi);
    nomorHpController = TextEditingController(text: widget.penginapan.nomorHp);
    imageUrlController =
        TextEditingController(text: widget.penginapan.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Penginapan'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final updatedPenginapan = Penginapan(
                namaController.text,
                lokasiController.text,
                nomorHpController.text,
                imageUrlController.text,
              );
              widget.onUpdate(updatedPenginapan);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: lokasiController,
              decoration: InputDecoration(labelText: 'Lokasi'),
            ),
            TextField(
              controller: nomorHpController,
              decoration: InputDecoration(labelText: 'Nomor HP'),
            ),
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddPenginapanDialog extends StatelessWidget {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();
  final TextEditingController nomorHpController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  AddPenginapanDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tambah Penginapan'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: lokasiController,
              decoration: InputDecoration(labelText: 'Lokasi'),
            ),
            TextField(
              controller: nomorHpController,
              decoration: InputDecoration(labelText: 'Nomor HP'),
            ),
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Batal'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Tambah'),
          onPressed: () {
            final newPenginapan = Penginapan(
              namaController.text,
              lokasiController.text,
              nomorHpController.text,
              imageUrlController.text,
            );
            Navigator.of(context).pop(newPenginapan);
          },
        ),
      ],
    );
  }
}

class Penginapan {
  final String nama;
  final String lokasi;
  final String nomorHp;
  final String imageUrl;

  Penginapan(this.nama, this.lokasi, this.nomorHp, this.imageUrl);
}
