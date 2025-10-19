import 'package:flutter/material.dart';
import 'package:apktes1/presentation/screens/book_page.dart';
import 'package:apktes1/presentation/screens/cafe_page.dart';
import 'package:apktes1/presentation/screens/cats_page.dart';
import 'package:apktes1/presentation/screens/profile_page.dart';
import 'package:apktes1/presentation/screens/custom_navbar.dart';
import 'package:apktes1/presentation/screens/scan_page.dart';

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
    
    final String name = widget.email.contains("@")
        ? widget.email.split("@")[0]
        : widget.email;

   final List<Widget> pages = [
        BooksPage(userName: name),
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
            
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Barcode hasil: $result")),
            );
          }
        },
      ),
    );
  }
}
