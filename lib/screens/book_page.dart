import 'package:flutter/material.dart';

class BooksPage extends StatefulWidget {  // 🔹 ubah dari HomePage -> BooksPage
  final String userName;
  const BooksPage({super.key, required this.userName});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  int _selectedCategory = 0;

  final List<String> _categories = ["Semua", "Anak", "Sains", "Sejarah", "Novel"];

  final List<Map<String, String>> _books = [
    {"image": "assets/Cat.jpg", "title": "Atomic Habits", "author": "James Clear"},
    {"image": "assets/mam.jpg", "title": "Filosofi Kopi", "author": "Dewi Lestari"},
    {"image": "assets/meng.jpg", "title": "Norwegian Wood", "author": "Haruki Murakami"},
    {"image": "assets/pustakapaw.jpg", "title": "Laskar Pelangi", "author": "Andrea Hirata"},
  ];

  Widget _categoryChip(String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? Colors.brown : Colors.brown.shade100,
          borderRadius: BorderRadius.circular(22),
          boxShadow: isActive
              ? [BoxShadow(color: Colors.brown.withOpacity(0.25), blurRadius: 6, offset: const Offset(0, 3))]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.brown,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _bookCard(Map<String, String> book) {
    return GestureDetector(
      onTap: () {
        // bisa navigasi ke detail
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              child: Image.asset(
                book["image"]!,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book["title"]!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book["author"]!,
                    style: TextStyle(fontSize: 12, color: Colors.brown.shade400),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      alignment: Alignment.center,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.brown.withOpacity(0.2),
                            offset: const Offset(0, 3),
                            blurRadius: 5,
                          )
                        ],
                      ),
                      child: const Text(
                        "Pinjam",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _promoCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(right: 16),
      width: 280,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(215, 204, 200, 1),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Promo Spesial",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.brown),
          ),
          const SizedBox(height: 6),
          const Text(
            "Pinjam 3 buku sekaligus dan dapatkan waktu baca ekstra!",
            style: TextStyle(fontSize: 12, color: Colors.brown),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Pinjam",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
           // Header
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.menu_book, color: Colors.white, size: 36),
                  const SizedBox(height: 12),
                  Text(
                    "Halo, ${widget.userName} ",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Selamat datang di Meowread ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // 🔍 Search + Kategori Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search bar
                TextField(
                  decoration: InputDecoration(
                    hintText: "Cari buku...",
                    hintStyle: TextStyle(color: Colors.brown.shade300),
                    prefixIcon: const Icon(Icons.search, color: Colors.brown),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.brown, width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Bar Kategori (?)
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 8),
                    itemBuilder: (context, index) => _categoryChip(
                      _categories[index],
                      _selectedCategory == index,
                      () {
                        setState(() {
                          _selectedCategory = index;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),

            // Buku Terbaru
            const Text(
              "Rekomendasi Buku Terbaru",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 240,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _books.length,
                itemBuilder: (context, index) => _bookCard(_books[index]),
              ),
            ),

            const SizedBox(height: 24),

            // Promo
            const Text(
              "Promo Spesial",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(3, (_) => _promoCard()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
