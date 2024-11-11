import 'package:flutter/material.dart';
import 'login.dart'; // Import login.dart for logout navigation
import 'profil.dart'; // Import profil.dart for the profile screen
import 'penginapan.dart'; // Import penginapan.dart for the accommodation screen
import 'restoran.dart'; // Import restoran.dart for the restaurant screen
import 'wisata.dart'; // Import wisata.dart for the tourism screen
import 'riwayat_transaksi.dart'; // Import riwayat_transaksi.dart for transaction history
import 'tiket_saya.dart'; // Import tiket_saya.dart for user tickets

class DashboardScreen extends StatelessWidget {
  final String username; // Receive username from LoginScreen

  DashboardScreen({required this.username});

  // List of image asset paths
  final List<String> imageAssets = [
    'assets/images/bukit.png',
    'assets/images/manten.png',
    'assets/images/nilo.png',
    'assets/images/ponggok.png',
    'assets/images/candi.png',
    'assets/images/sigedang.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Destinasi Wisata',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF61AB32),
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        drawer: AppDrawer(username: username), // Pass username to drawer
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari di sini',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Text(
                  'Semua Wisata',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                // Full-width image slider
                Container(
                  height: 200, // Adjust the height as needed
                  child: PageView.builder(
                    itemCount: imageAssets.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Image.asset(
                          imageAssets[index],
                          fit: BoxFit.cover,
                          width:
                              double.infinity, // Make the image fill the width
                        ),
                      );
                    },
                    // Looping effect by using PageController with a large initial value
                    controller: PageController(viewportFraction: 1.0),
                    onPageChanged: (index) {
                      // If needed, you can implement any behavior on page change
                    },
                  ),
                ),
                SizedBox(height: 20),
                // Navigation buttons for different categories
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.travel_explore, size: 50),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WisataScreen()),
                            );
                          },
                        ),
                        Text('Wisata', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.hotel, size: 50),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PenginapanScreen()),
                            );
                          },
                        ),
                        Text('Penginapan', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.restaurant, size: 50),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RestoranScreen()),
                            );
                          },
                        ),
                        Text('Restoran', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // New buttons for transaction history and user tickets
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.history, size: 50),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RiwayatTransaksiPage()),
                            );
                          },
                        ),
                        Text('Riwayat Transaksi',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.confirmation_number, size: 50),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TiketSayaScreen(
                                    username: username), // Pass username here
                              ),
                            );
                          },
                        ),
                        Text('Tiket Saya', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class AppDrawer extends StatelessWidget {
  final String username; // Receive username from DashboardScreen

  AppDrawer({required this.username});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(username), // Display username
            accountEmail: Text(""),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 50),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profil'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilScreen(
                        username: username)), // Navigate to ProfilScreen
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.travel_explore),
            title: Text('Daftar Wisata'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        WisataScreen()), // Navigate to WisataScreen
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.hotel),
            title: Text('Daftar Penginapan'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PenginapanScreen()), // Navigate to PenginapanScreen
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.restaurant),
            title: Text('Daftar Restoran'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        RestoranScreen()), // Navigate to RestoranScreen
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Riwayat Transaksi'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        RiwayatTransaksiPage()), // Navigate to RiwayatTransaksiScreen
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.confirmation_number),
            title: Text('Tiket Saya'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TiketSayaScreen(
                        username: username)), // Navigate to TiketSayaScreen
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LoginScreen()), // Go back to login page on logout
                (route) => false, // Remove all previous routes
              );
            },
          ),
        ],
      ),
    );
  }
}
