import 'package:flutter/material.dart';

class Wisata {
  final String title;
  final String location;
  final String imageUrl;
  final int harga;

  Wisata(this.title, this.location, this.imageUrl, this.harga);
}

final List<Wisata> wisataList = [
  Wisata('Umbul Sigedang', 'Pusur, Karanglo, Polanharjo', 'assets/images/sigedang.png', 10000),
  Wisata('Umbul Manten', 'Boto, Wunut, Tulung', 'assets/images/manten.png', 10000),
  Wisata('Umbul Nilo', 'Daleman, Tulung', 'assets/images/nilo.png', 8000),
  Wisata('Umbul Ponggok', 'Jeblogan, Ponggok, Polanharjo', 'assets/images/ponggok.png', 10000),
  Wisata('Candi Plaosan', 'Plaosan Lor, Bugisan, Prambanan', 'assets/images/candi.png', 5000),
  Wisata('Bukit Cinta', 'Gn. Gajah, Bayat', 'assets/images/bukit.png', 50000),
];

class PengunjungScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Wisata'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: wisataList.length,
        itemBuilder: (context, index) {
          final wisata = wisataList[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Image.asset(wisata.imageUrl, width: 80, fit: BoxFit.cover),
              title: Text(wisata.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(wisata.location),
                  SizedBox(height: 4),
                  Text('Harga: Rp. ${wisata.harga}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people, color: Colors.grey),
                  Text('Pengunjung'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
