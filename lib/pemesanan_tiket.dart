import 'package:flutter/material.dart';
import 'kode.dart'; // Pastikan ini mengarah ke file yang sesuai

class PemesananTiketScreen extends StatelessWidget {
  final String destination;
  final String namaPemesan;
  final int totalTickets;
  final int totalHarga;

  const PemesananTiketScreen({
    Key? key,
    required this.destination,
    required this.namaPemesan,
    required this.totalTickets,
    required this.totalHarga,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Pemesanan",
          style: TextStyle(
              color: Colors.white), // Mengubah warna teks menjadi putih
        ),
        backgroundColor:
            Color(0xFF61AB32), // Mengubah warna hijau menjadi #61AB32
        iconTheme: const IconThemeData(
            color: Colors.white), // Mengubah warna ikon menjadi putih
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Destinasi: $destination",
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black), // Warna teks hitam
            ),
            const SizedBox(height: 10),
            Text(
              "Total Tiket: $totalTickets",
              style: const TextStyle(
                  fontSize: 16, color: Colors.black), // Warna teks hitam
            ),
            const SizedBox(height: 10),
            Text(
              "Total Harga: Rp$totalHarga",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black), // Warna teks hitam
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman KodeTiketPage setelah konfirmasi
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KodeTiketPage(
                        destination: destination,
                        totalHarga: totalHarga,
                        jumlahTiket: totalTickets, // Kirimkan jumlah tiket
                      ),
                    ),
                  );
                },
                child: const Text("Konfirmasi",
                    style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(
                      0xFF61AB32), // Mengubah warna tombol menjadi #61AB32
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
