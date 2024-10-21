import 'package:flutter/material.dart';
import 'detail_tiket.dart'; // Import screen for ticket details

class TiketSayaScreen extends StatelessWidget {
  final String username;

  TiketSayaScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tiket Saya'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: 4, // Example with 4 tickets
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // When the ticket is clicked, navigate to the detail page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TiketDetailScreen(username: username),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[300],
                  child: Icon(Icons.image, size: 40, color: Colors.grey),
                ),
                title: Text('Item Tiket ${index + 1}'),
                subtitle: Text('Detail acara wisata tiket ${index + 1}'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
        },
      ),
    );
  }
}
