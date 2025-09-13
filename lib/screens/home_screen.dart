import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String email; // data yang dikirim dari Login

  const HomeScreen({super.key, required this.email}); // constructor butuh email

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  String _getGreeting(String name) {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return "Good Morning, $name!";
    if (hour >= 12 && hour < 16) return "Good Afternoon, $name!";
    if (hour >= 16 && hour < 19) return "Good Evening, $name!";
    return "Good Night, $name!";
  }

  @override
  Widget build(BuildContext context) {
    final String name = (widget.email.contains("@"))
        ? widget.email.split("@")[0]
        : widget.email;

    final List<Widget> pages = [
      BooksPage(),
      CafePage(),
      CatsPage(),
      ProfilePage(name: name),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF6D4C41), // coklat tua
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Buku"),
          BottomNavigationBarItem(icon: Icon(Icons.local_cafe), label: "Cafe"),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: "Kucing"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}

// =================== HALAMAN ===================

class BooksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Buku"), backgroundColor: Colors.brown),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _bookCard("Atomic Habits", "James Clear"),
          _bookCard("Filosofi Kopi", "Dewi Lestari"),
          _bookCard("Norwegian Wood", "Haruki Murakami"),
        ],
      ),
    );
  }

  Widget _bookCard(String title, String author) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: const Color(0xFFD7CCC8),
      child: ListTile(
        leading: const Icon(Icons.menu_book, color: Colors.brown),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(author),
        trailing: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text("Pinjam"),
        ),
      ),
    );
  }
}

class CafePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cafe"), backgroundColor: Colors.brown),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: [
          _menuCard("Cappuccino", "Rp 25.000"),
          _menuCard("Teh Hijau", "Rp 15.000"),
          _menuCard("Croissant", "Rp 18.000"),
          _menuCard("Mie Goreng", "Rp 22.000"),
        ],
      ),
    );
  }

  Widget _menuCard(String name, String price) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(8),
      color: const Color(0xFFD7CCC8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_cafe, size: 40, color: Colors.brown),
            const SizedBox(height: 10),
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(price, style: const TextStyle(color: Colors.brown)),
          ],
        ),
      ),
    );
  }
}

class CatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kucing di Perpustakaan"), backgroundColor: Colors.brown),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Pilih teman kucingmu 🐱",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            SizedBox(
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CatCard(name: "Mochi", age: "2 tahun", mood: "Playful", color: Color(0xFFD7CCC8)),
                  CatCard(name: "Choco", age: "1 tahun", mood: "Pemalu", color: Color(0xFFBCAAA4)),
                  CatCard(name: "Luna", age: "3 tahun", mood: "Suka tidur", color: Color(0xFFA1887F)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CatCard extends StatelessWidget {
  final String name;
  final String age;
  final String mood;
  final Color color;

  const CatCard({
    super.key,
    required this.name,
    required this.age,
    required this.mood,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.pets, size: 60, color: Colors.brown), // nanti bisa diganti gambar kucing
            const SizedBox(height: 10),
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(age, style: const TextStyle(fontSize: 13)),
            Text(mood, style: const TextStyle(color: Colors.brown)),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final String name;
  const ProfilePage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profil Saya"), backgroundColor: Colors.brown),
      body: Center(
        child: Text(
          "Hello, $name!",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
