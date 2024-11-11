import 'package:flutter/material.dart';
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

  int get _totalHarga => _jumlahTiket * widget.tiketMasuk;

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
        title: Text('Pesan Tiket untuk ${widget.destination}'),
        backgroundColor: Colors.green.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tiket untuk ${widget.destination}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Harga tiket: Rp. ${widget.tiketMasuk}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Jumlah Tiket:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: _kurangiTiket,
                ),
                Text(
                  '$_jumlahTiket',
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _tambahTiket,
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Total Harga: Rp. $_totalHarga',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      namaPemesan: "Nama Pemesan", // Ganti dengan nama pemesan
                      totalTickets: _jumlahTiket,
                      totalHarga: _totalHarga, // Kirim total harga yang benar
                    ),
                  ),
                );
              },
              child: Text('Pesan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade400,
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
