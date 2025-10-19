import 'package:flutter/material.dart';
import 'package:apktes1/app/data/models/cat.dart';
import 'package:apktes1/presentation/screens/CatDetailPage.dart';


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

  final List<Cat> cats = [
    CampusCat(
      "Mana Tahan",
      "2 tahun",
      "Playful",
      "assets/cats/wlee.jpg",
      "Kucing ini sangat aktif dan suka bermain di sekitar kampus. "
          "Ia ramah dengan orang baru dan selalu mencari perhatian 🐾.",
      ["assets/cats/wlee.jpg"],
    ),
    LocalCat(
      "Gosong",
      "1 tahun",
      "Nakal",
      "assets/cats/gosong.jpg",
      "Kucing kecil dengan bulu hitam legam. "
          "Meski nakal, ia sangat menggemaskan dan suka berlari-lari.",
      ["assets/cats/gosong.jpg"],
    ),
    LocalCat(
      "Bobby",
      "3 tahun",
      "Suka tidur",
      "assets/cats/bobby.jpg",
      "Bobby sangat santai. Hobinya tidur di tempat yang hangat "
          "dan suka dipangku saat sore hari.",
      ["assets/cats/bobby.jpg"],
    ),
    LocalCat(
      "Shepy",
      "3 tahun",
      "Amimir",
      "assets/cats/shepy.jpg",
      "Kucing ini suka menyendiri, jarang terlihat, tapi sekali muncul jadi pusat perhatian.",
      ["assets/cats/shepy.jpg"],
    ),
    LocalCat(
      "Miko",
      "1.5 tahun",
      "Penjelajah",
      "assets/cats/Cat.jpg",
      "Miko adalah kucing yang sangat penasaran dan suka menjelajahi setiap sudut rumah. Bulunya lembut dan matanya tajam.",
      ["assets/cats/Cat.jpg"],
    ),
    CampusCat(
      "Si Putih",
      "4 tahun",
      "Anggun",
      "assets/cats/pustakapaw.jpg",
      "Kucing kampus yang anggun dengan bulu putih bersih. Sering terlihat berjemur di bawah sinar matahari.",
      ["assets/cats/pustakapaw.jpg"],
    ),
    LocalCat(
      "Oyen",
      "2 tahun",
      "Usil",
      "assets/cats/mam.jpg",
      "Oyen adalah kucing lokal yang terkenal usil tapi sangat penyayang. Suka mencuri perhatian dengan tingkah lucunya.",
      ["assets/cats/mam.jpg"],
    ),
    LocalCat(
      "Ciko",
      "1 tahun",
      "Lincah",
      "assets/cats/wlee.jpg",
      "Ciko adalah kucing muda yang sangat lincah dan suka bermain dengan bola benang. Energinya tidak ada habisnya!",
      ["assets/cats/wlee.jpg"],
    ),
    CampusCat(
      "Profesor",
      "5 tahun",
      "Bijaksana",
      "assets/cats/gosong.jpg",
      "Kucing kampus yang paling tua dan bijaksana. Sering terlihat duduk tenang di perpustakaan kampus.",
      ["assets/cats/gosong.jpg"],
    ),
    LocalCat(
      "Cuki",
      "1.5 tahun",
      "Pemalu",
      "assets/cats/sicuki.jpg",
      "Kucing pemalu yang suka bersembunyi di balik semak-semak, tapi sangat manis jika sudah kenal.",
      ["assets/cats/sicuki.jpg"],
    ),
    CampusCat(
      "Toldon",
      "2 tahun",
      "Penjaga",
      "assets/cats/sitoldon.jpg",
      "Kucing besar yang selalu waspada, sering terlihat menjaga area sekitar kampus.",
      ["assets/cats/sitoldon.jpg"],
    ),
    LocalCat(
      "Sion",
      "3 tahun",
      "Santai",
      "assets/cats/sioon_merem.jpg",
      "Kucing yang sangat santai, sering terlihat tidur dengan mata terpejam di tempat-tempat nyaman.",
      ["assets/cats/sioon_merem.jpg"],
    ),
    LocalCat(
      "Pino",
      "4 tahun",
      "Tidur",
      "assets/cats/Sipino_turu.jpg",
      "Pino adalah master tidur, bisa tidur di mana saja dan kapan saja, bahkan di posisi yang aneh.",
      ["assets/cats/Sipino_turu.jpg"],
    ),
    LocalCat(
      "Thinker",
      "2.5 tahun",
      "Pemikir",
      "assets/cats/kucing_let_me_think.jpg",
      "Kucing yang selalu terlihat merenung, seolah sedang memikirkan masalah dunia dengan ekspresi serius.",
      ["assets/cats/kucing_let_me_think.jpg"],
    ),
    CampusCat(
      "Putih Kampus",
      "3 tahun",
      "Bersih",
      "assets/cats/kucing_putih_kampus1.jpg",
      "Kucing kampus dengan bulu putih bersih, sangat menjaga penampilannya dan suka berjemur.",
      ["assets/cats/kucing_putih_kampus1.jpg"],
    ),
    CampusCat(
      "Anak Kampus",
      "0.5 tahun",
      "Imut",
      "assets/cats/anaknya_kucing_kampus.jpg",
      "Anak kucing kampus yang sangat imut dan suka bermain dengan teman-temannya di area kampus.",
      ["assets/cats/anaknya_kucing_kampus.jpg"],
    ),
    LocalCat(
      "Wireless",
      "2 tahun",
      "Manja",
      "assets/cats/elus_kucing_wirellees.jpg",
      "Kucing yang suka dielus, terutama di bagian kepala dan punggung. Sangat manja dan suka dekat dengan manusia.",
      ["assets/cats/elus_kucing_wirellees.jpg"],
    ),
    CampusCat(
      "Ibu Kampus",
      "4 tahun",
      "Penyayang",
      "assets/cats/Kucing_kampus_bersama_anaknya.jpg",
      "Induk kucing kampus yang sangat penyayang, selalu menjaga anak-anaknya dengan penuh kasih sayang.",
      ["assets/cats/Kucing_kampus_bersama_anaknya.jpg"],
    ),
    CampusCat(
      "Keluarga Kampus",
      "4 tahun",
      "Bersama",
      "assets/cats/Kucing_kampus_bersama_anaknya2.jpg",
      "Kucing kampus yang selalu terlihat bersama anak-anaknya, menunjukkan kehangatan keluarga kucing.",
      ["assets/cats/Kucing_kampus_bersama_anaknya2.jpg"],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredCats = cats.where((cat) {
      final matchesSearch = cat.name.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == "All" || cat.category == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pustakapawmu",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: theme.primaryColor, 
        elevation: 0,
      ),
      body: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: theme.primaryColor),
                hintText: "Cari kucing kesayanganmu...",
                filled: true,
                fillColor: theme.cardColor,
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
                      color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  selectedColor: theme.primaryColor,
                  backgroundColor: theme.cardColor.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 2,
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: filteredCats.isEmpty
                ? Center(
                    child: Text(
                      "Tidak ada kucing ditemukan 🐱",
                      style: TextStyle(fontSize: 16, color: theme.hintColor),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: filteredCats.length,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder: (context, index) {
                      final cat = filteredCats[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => CatDetailPage(cat: cat),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                const begin = Offset(0.0, 1.0);
                                const end = Offset.zero;
                                const curve = Curves.easeInOut;
                                final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
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
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
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
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  cat.name,
                                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
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
