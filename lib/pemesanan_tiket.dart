import 'package:flutter/material.dart';
import 'kode.dart'; // Pastikan impor ini sesuai lokasi file KodeTiketPage

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
        title: const Text("Detail Pemesanan"),
        backgroundColor: Colors.green.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Destinasi: $destination",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Total Tiket: $totalTickets",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              "Total Harga: Rp$totalHarga",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        jumlahTiket:
                            totalTickets, // Pastikan jumlahTiket disertakan
                      ),
                    ),
                  );
                },
                child: const Text("Konfirmasi"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade400,
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
