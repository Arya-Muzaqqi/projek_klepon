import 'package:flutter/material.dart';

class RiwayatTransaksiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Transaksi'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: 5, // Jumlah transaksi yang ingin ditampilkan
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.history),
              title: Text('Transaksi $index'),
            ),
          );
        },
      ),
    );
  }
}
