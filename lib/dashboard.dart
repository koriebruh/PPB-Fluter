import 'package:flutter/material.dart';
import 'package:restofatlem_14624/app_bar.dart';
import 'package:restofatlem_14624/product_list.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool showProductList = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: showProductList
            ? ProductList() // Menampilkan daftar produk
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Selamat Datang di Aplikasi RestoKorie!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'JetBrainsMono',
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Aplikasi ini menyediakan berbagai produk yang bisa Anda pilih dan pesan dengan mudah. '
                  'Temukan produk terbaik dan buat pengalaman belanja Anda lebih menyenangkan!',
              style: TextStyle(fontSize: 16, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showProductList = true; // Menampilkan daftar produk
                });
              },
              child: Text('Menuju ke Produk'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
