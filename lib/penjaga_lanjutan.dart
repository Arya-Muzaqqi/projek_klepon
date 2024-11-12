import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TiketLanjutan extends StatelessWidget {
  final String ticketCode;

  const TiketLanjutan({super.key, required this.ticketCode});

  // Mengambil data tiket dari Firestore berdasarkan ticketCode
  Future<DocumentSnapshot?> _getTicketData() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('ticket_codes')
          .where('ticket_code', isEqualTo: ticketCode)
          .limit(1)
          .get();
      return snapshot.docs.isNotEmpty ? snapshot.docs.first : null;
    } catch (e) {
      print("Error getting ticket data: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white), // Mengubah ikon kembali menjadi putih
        title: Text('Konfirmasi Tiket', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF61AB32),
      ),
      body: FutureBuilder<DocumentSnapshot?>(
        future: _getTicketData(), // Memanggil fungsi untuk mengambil data tiket
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan, coba lagi.'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Data tidak ditemukan.'));
          }

          // Ambil data dari Firestore
          var ticketData = snapshot.data!;
          String namaWisata = ticketData['destination'] ?? 'Tidak Diketahui';

          // Mengonversi total_tickets ke tipe int, jika gagal, default 0
          int totalTiket =
              int.tryParse(ticketData['total_tickets'].toString()) ?? 0;

          // Mengonversi total_harga ke tipe double menggunakan double.tryParse dan menghilangkan angka di belakang koma
          double totalHarga =
              double.tryParse(ticketData['total_harga'].toString()) ?? 0.0;

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 100,
                    color: Colors.green,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Tiket Berhasil Digunakan!',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Menampilkan data dari Firestore dengan desain yang lebih elegan
                  Text(
                    'Nama Wisata:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    namaWisata,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Total Tiket:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '$totalTiket Tiket',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Total Harga:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Rp${totalHarga.toInt()}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Tombol Kembali dengan warna hijau dan teks putih
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF61AB32), // Warna hijau
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Kembali ke halaman sebelumnya
                    },
                    child: Text(
                      'Kembali',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white, // Warna tulisan putih
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
