import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TiketSayaScreen extends StatelessWidget {
  final String username;

  // Constructor untuk menerima username
  TiketSayaScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tiket Saya", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF61AB32),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(
                      'ticket_codes') // Mengambil dari koleksi 'ticket_codes'
                  .where('user_id',
                      isEqualTo: FirebaseAuth.instance.currentUser!
                          .uid) // Filter berdasarkan user_id
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("Anda belum memesan tiket"));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var ticket = snapshot.data!.docs[index];
                    return Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kode Tiket: ${ticket['ticket_code']}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Wisata: ${ticket['destination']}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text("Jumlah Tiket: ${ticket['total_tickets']}",
                                style: TextStyle(fontSize: 16)),
                            Text("Total Harga: Rp ${ticket['total_harga']}",
                                style: TextStyle(fontSize: 16)),
                            Text(
                              "Status: ${ticket['status']}",
                              style: TextStyle(
                                fontSize: 16,
                                color: ticket['status'] == 'used'
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
