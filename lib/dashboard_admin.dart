import 'package:flutter/material.dart';
import 'login.dart'; // Import login.dart for logout navigation
import 'wisata.dart'; // Import wisata.dart for the tourism screen
import 'penginapan.dart'; // Import penginapan.dart for the accommodation screen
import 'restoran.dart'; // Import restoran.dart for the restaurant screen

class DashboardAdminScreen extends StatelessWidget {
  final String username; // Receive username from LoginScreen

  DashboardAdminScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard Admin'),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: AdminDrawer(username: username), // Pass username to drawer
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            SizedBox(height: 20),
            // Display a placeholder for visitor count
            Container(
              height: 150,
              width: double.infinity,
              color: Color(0xFF61AB32),
              child: Center(
                child: Text(
                  'Jumlah Pengunjung Hari Ini: 1250', // Example visitor count
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Display icons in 2x2 grid
            Wrap(
              spacing: 40.0, // Space between the icons horizontally
              runSpacing: 30.0, // Space between the icons vertically
              alignment: WrapAlignment.center,
              children: [
                // Icon for "Wisata"
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.travel_explore, size: 50),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WisataScreen()),
                        );
                      },
                    ),
                    Text('Wisata', style: TextStyle(fontSize: 16)),
                  ],
                ),
                // Icon for "Penginapan"
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.hotel, size: 50),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PenginapanScreen()),
                        );
                      },
                    ),
                    Text('Penginapan', style: TextStyle(fontSize: 16)),
                  ],
                ),
                // Icon for "Restoran"
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.restaurant, size: 50),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RestoranScreen()),
                        );
                      },
                    ),
                    Text('Restoran', style: TextStyle(fontSize: 16)),
                  ],
                ),
                // Icon for "Jumlah Pengunjung"
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.people, size: 50),
                      onPressed: () {
                        // Stay on the same page
                        Navigator.pop(context);
                      },
                    ),
                    Text('Pengunjung', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AdminDrawer extends StatelessWidget {
  final String username; // Receive username from DashboardAdminScreen

  AdminDrawer({required this.username});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(username), // Display username
            accountEmail: Text("admin@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 50),
            ),
          ),
          ListTile(
            leading: Icon(Icons.travel_explore),
            title: Text('Daftar Wisata'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WisataScreen()), // Navigate to WisataScreen
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.hotel),
            title: Text('Daftar Penginapan'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PenginapanScreen()), // Navigate to PenginapanScreen
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.restaurant),
            title: Text('Daftar Restoran'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RestoranScreen()), // Navigate to RestoranScreen
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Jumlah Pengunjung'),
            onTap: () {
              Navigator.pop(context); // Stay on current screen
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()), // Go back to login page on logout
                (route) => false, // Remove all previous routes
              );
            },
          ),
        ],
      ),
    );
  }
}
