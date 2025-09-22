import 'package:flutter/material.dart';
import 'book_page.dart';
import 'cafe_page.dart';
import 'cats_page.dart';
import 'profile_page.dart';
import 'custom_navbar.dart';
import 'scan_page.dart'; 

class HomeScreen extends StatefulWidget {
  final String email;

  const HomeScreen({super.key, required this.email});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // ambil nama dari email sebelum tanda @
    final String name = widget.email.contains("@")
        ? widget.email.split("@")[0]
        : widget.email;

   final List<Widget> pages = [
        BooksPage(userName: name),   // 🔹 ini sudah cocok
        const CafePage(),
        const CatsPage(),
        ProfilePage(name: name, email: widget.email),
      ];
      
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: CustomNavbar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        onScanTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScanPage()),
          );

          if (result != null) {
            // ✅ tampilkan hasil scan ke user
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Barcode hasil: $result")),
            );
          }
        },
      ),
    );
  }
}
