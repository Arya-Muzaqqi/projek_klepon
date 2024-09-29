import 'package:flutter/material.dart';

class LoketScreen extends StatefulWidget {
  @override
  _LoketScreenState createState() => _LoketScreenState();
}

class _LoketScreenState extends State<LoketScreen> {
  final TextEditingController _ticketCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loket'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/images/logo.png', // Ganti dengan path logo kamu
              height: 150, // Atur ukuran sesuai kebutuhan
            ),
            SizedBox(height: 30),

            // Placeholder image (X image as per wireframe)
            Container(
              height: 150,
              width: 150,
              color: Colors.grey[300], // Placeholder for image
              child: Icon(Icons.image, size: 100, color: Colors.grey),
            ),
            SizedBox(height: 30),
            
            // Input field for ticket code
            TextField(
              controller: _ticketCodeController,
              decoration: InputDecoration(
                labelText: 'Masukkan Kode Tiket',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            
            // Confirmation button
            ElevatedButton(
              onPressed: () {
                // Handle confirmation logic here
                if (_ticketCodeController.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TicketSuccessScreen()),
                  );
                } else {
                  // Show warning if the input is empty
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Peringatan'),
                        content: Text('Harap masukkan kode tiket'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Konfirmasi'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TicketSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tiket Berhasil'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Success message
            Text(
              'Tiket Berhasil digunakan',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            
            // Placeholder for ticket info
            Container(
              height: 150,
              width: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Text(
                  'Informasi Tiket',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 30),
            
            // Back button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Kembali'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
