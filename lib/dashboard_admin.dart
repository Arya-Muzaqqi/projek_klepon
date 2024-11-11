import 'package:flutter/material.dart';
import 'login.dart';
import 'wisata_admin.dart';
import 'penginapan_admin.dart';
import 'restoran_admin.dart';
import 'pengunjung.dart'; // Import pengunjung.dart

class DashboardAdminScreen extends StatelessWidget {
  final String username;

  const DashboardAdminScreen({super.key, required this.username});

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
        drawer: AdminDrawer(username: username),
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
                SizedBox(height: 20),
                Container(
                  height: 150,
                  width: double.infinity,
                  color: Color(0xFF61AB32),
                  child: Center(
                    child: Text(
                      'Jumlah Pengunjung Hari Ini:',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Wrap(
                  spacing: 40.0,
                  runSpacing: 30.0,
                  alignment: WrapAlignment.center,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.travel_explore, size: 50),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WisataAdminScreen()),
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
                                  builder: (context) =>
                                      PenginapanAdminScreen()),
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
                                  builder: (context) => RestoranAdminScreen()),
                            );
                          },
                        ),
                        Text('Restoran', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.people, size: 50),
                          onPressed: () {
                            // Navigate to PengunjungScreen when icon is pressed
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PengunjungScreen()),
                            );
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
        ));
  }
}

class AdminDrawer extends StatelessWidget {
  final String username;

  const AdminDrawer({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(username),
            accountEmail: Text("ADMIN"),
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
                MaterialPageRoute(builder: (context) => WisataAdminScreen()),
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
                    builder: (context) => PenginapanAdminScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.restaurant),
            title: Text('Daftar Restoran'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RestoranAdminScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Jumlah Pengunjung'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PengunjungScreen()),
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
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
