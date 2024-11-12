import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'pemesanan_tiket.dart'; // Import halaman pemesanan_tiket.dart

class PesanTiketPage extends StatefulWidget {
  final String destination;
  final int tiketMasuk;

  const PesanTiketPage({
    super.key,
    required this.destination,
    required this.tiketMasuk,
  });

  @override
  _PesanTiketPageState createState() => _PesanTiketPageState();
}

class _PesanTiketPageState extends State<PesanTiketPage> {
  int _jumlahTiket = 1;
  String _namaPemesan = ''; // Untuk menyimpan nama pemesan

  int get _totalHarga => _jumlahTiket * widget.tiketMasuk;

  @override
  void initState() {
    super.initState();
    _getNamaPemesan(); // Memanggil fungsi untuk mengambil nama pemesan dari Firestore
  }

  // Fungsi untuk mengambil nama pengguna dari Firestore berdasarkan UID
  Future<void> _getNamaPemesan() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Ambil data pengguna dari Firestore berdasarkan UID
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        _namaPemesan = userDoc['name']; // Ambil nama pengguna dari Firestore
      });
    }
  }

  void _tambahTiket() {
    setState(() {
      _jumlahTiket++;
    });
  }

  void _kurangiTiket() {
    if (_jumlahTiket > 1) {
      setState(() {
        _jumlahTiket--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pesan Tiket untuk ${widget.destination}',
          style: TextStyle(
              color: Colors.white), // Mengubah warna teks judul menjadi putih
        ),
        backgroundColor:
            Color(0xFF61AB32), // Mengubah warna hijau menjadi #61AB32
        iconTheme: IconThemeData(
            color: Colors.white), // Mengubah warna ikon kembali menjadi putih
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tiket untuk ${widget.destination}',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black), // Mengubah warna teks menjadi hitam
            ),
            SizedBox(height: 20),
            Text(
              'Harga tiket: Rp. ${widget.tiketMasuk}',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black), // Mengubah warna teks menjadi hitam
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Jumlah Tiket:',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black), // Mengubah warna teks menjadi hitam
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: _kurangiTiket,
                  color: Colors.black, // Mengubah warna ikon menjadi hitam
                ),
                Text(
                  '$_jumlahTiket',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black), // Mengubah warna teks menjadi hitam
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _tambahTiket,
                  color: Colors.black, // Mengubah warna ikon menjadi hitam
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Total Harga: Rp. $_totalHarga',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black), // Mengubah warna teks menjadi hitam
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Kirim data ke PemesananTiketScreen dengan total harga yang benar
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PemesananTiketScreen(
                      destination: widget.destination,
                      namaPemesan:
                          _namaPemesan, // Kirim nama pemesan yang diambil dari Firebase
                      totalTickets: _jumlahTiket,
                      totalHarga: _totalHarga, // Kirim total harga yang benar
                    ),
                  ),
                );
              },
              child: Text('Pesan', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color(0xFF61AB32), // Mengubah warna tombol menjadi #61AB32
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
