import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RiwayatTransaksiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Transaksi",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF61AB32),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('ticket_codes') // Menggunakan koleksi 'ticket_codes'
            .where('user_id',
                isEqualTo: FirebaseAuth
                    .instance.currentUser!.uid) // Filter berdasarkan user_id
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("Belum ada riwayat transaksi"));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var ticket = snapshot.data!.docs[index];
              return ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                title: Text(
                  "Wisata: ${ticket['destination']}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text("Jumlah Tiket: ${ticket['total_tickets']}",
                        style: TextStyle(fontSize: 16)),
                    Text("Total Harga: Rp ${ticket['total_harga']}",
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
                onTap: () {
                  // Bisa menampilkan detail transaksi jika diperlukan
                },
              );
            },
          );
        },
      ),
    );
  }
}
