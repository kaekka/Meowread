import 'package:flutter/material.dart';
import 'CatDetailPage.dart';

class Cat {
  final String _name;
  final String _age;
  final String _mood;
  final String _image;
  final String _description;
  final List<String> _extraPhotos;

  Cat(
    this._name,
    this._age,
    this._mood,
    this._image,
    this._description,
    this._extraPhotos,
  );

  // Getter → enkapsulasi
  String get name => _name;
  String get age => _age;
  String get mood => _mood;
  String get image => _image;
  String get description => _description;
  List<String> get extraPhotos => _extraPhotos;

  // Default kategori → dioverride oleh subclass
  String get category => "Kucing Umum";
}

// Subclass sesuai kategori (inheritance + polymorphism)
class CampusCat extends Cat {
  CampusCat(
    String name,
    String age,
    String mood,
    String image,
    String description,
    List<String> extraPhotos,
  ) : super(name, age, mood, image, description, extraPhotos);

  @override
  String get category => "Kucing Kampus";
}

class LocalCat extends Cat {
  LocalCat(
    String name,
    String age,
    String mood,
    String image,
    String description,
    List<String> extraPhotos,
  ) : super(name, age, mood, image, description, extraPhotos);

  @override
  String get category => "Kucing Lokal";
}

class OtherCat extends Cat {
  OtherCat(
    String name,
    String age,
    String mood,
    String image,
    String description,
    List<String> extraPhotos,
  ) : super(name, age, mood, image, description, extraPhotos);

  @override
  String get category => "Kucing Kucingan";
}

// Halaman utama
class CatsPage extends StatefulWidget {
  const CatsPage({super.key});

  @override
  State<CatsPage> createState() => _CatsPageState();
}

class _CatsPageState extends State<CatsPage> {
  String searchQuery = "";
  String selectedCategory = "All";

  final List<String> categories = [
    "All",
    "Kucing Kampus",
    "Kucing Lokal",
    "Kucing Kucingan",
  ];

  // List kucing 
  final List<Cat> cats = [
    CampusCat(
      "Mana Tahan",
      "2 tahun",
      "Playful",
      "assets/wlee.jpg",
      "Kucing ini sangat aktif dan suka bermain di sekitar kampus. "
          "Ia ramah dengan orang baru dan selalu mencari perhatian 🐾.",
      [
        "assets/wlee.jpg",
      ],
    ),
    LocalCat(
      "Gosong",
      "1 tahun",
      "Nakal",
      "assets/gosong.jpg",
      "Kucing kecil dengan bulu hitam legam. "
          "Meski nakal, ia sangat menggemaskan dan suka berlari-lari.",
      [
        "assets/gosong.jpg",
      ],
    ),
    LocalCat(
      "Bobby",
      "3 tahun",
      "Suka tidur",
      "assets/bobby.jpg",
      "Bobby sangat santai. Hobinya tidur di tempat yang hangat "
          "dan suka dipangku saat sore hari.",
      [
        "assets/bobby.jpg",
      ],
    ),
    LocalCat(
      "Shepy",
      "3 tahun",
      "Amimir",
      "assets/shepy.jpg",
      "Kucing ini suka menyendiri, jarang terlihat, tapi sekali muncul jadi pusat perhatian.",
      [
        "assets/shepy.jpg",
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredCats = cats.where((cat) {
      final matchesSearch =
          cat.name.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory =
          selectedCategory == "All" || cat.category == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: const Text(
          "Pustakapawmu ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.brown),
                hintText: "Cari kucing kesayanganmu...",
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),

          // Bar Kategori (?)
          SizedBox(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                return ChoiceChip(
                  label: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.brown[800],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  selectedColor: const Color.fromRGBO(121, 85, 72, 1),
                  backgroundColor: Colors.brown[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 3,
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: filteredCats.isEmpty
                ? const Center(
                    child: Text(
                      "Tidak ada kucing ditemukan 🐱",
                      style: TextStyle(fontSize: 16, color: Colors.brown),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    itemCount: filteredCats.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final cat = filteredCats[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  CatDetailPage(cat: cat),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin = Offset(0.0, 1.0);
                                const end = Offset.zero;
                                const curve = Curves.easeInOut;
                                final tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.brown.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Hero(
                                tag: cat.image,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    cat.image,
                                    height: 140,
                                    width: 140,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                cat.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
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
