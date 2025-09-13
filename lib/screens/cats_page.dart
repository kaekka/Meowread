import 'package:flutter/material.dart';

class CatsPage extends StatefulWidget {
  const CatsPage({super.key});

  @override
  State<CatsPage> createState() => _CatsPageState();
}

class _CatsPageState extends State<CatsPage> {
  String? selectedCat;

  // Daftar kucing dengan foto
  final List<Map<String, String>> cats = [
    {"name": "Mochi", "age": "2 tahun", "mood": "Playful", "image": "assets/cats/mochi.png"},
    {"name": "Choco", "age": "1 tahun", "mood": "Pemalu", "image": "assets/cats/choco.png"},
    {"name": "Luna", "age": "3 tahun", "mood": "Suka tidur", "image": "assets/cats/luna.png"},
    {"name": "Oreo", "age": "2 tahun", "mood": "Aktif", "image": "assets/cats/oreo.png"},
    {"name": "Mimi", "age": "4 bulan", "mood": "Manja", "image": "assets/cats/mimi.png"},
    {"name": "Tiger", "age": "5 tahun", "mood": "Kalem", "image": "assets/cats/tiger.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Profil Kucing"),
        backgroundColor: Colors.brown,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Pilih kucingmu 🐾",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          // Grid daftar kucing
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: cats.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final cat = cats[index];
                final isSelected = selectedCat == cat["name"];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCat = cat["name"];
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.brown[200] : Colors.brown[50],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? Colors.brown : Colors.transparent,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            cat["image"]!,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          cat["name"] ?? "",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(cat["age"] ?? "", style: const TextStyle(fontSize: 12)),
                        Text(cat["mood"] ?? "", style: const TextStyle(fontSize: 12, color: Colors.brown)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
