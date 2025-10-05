import 'package:apktes1/app/data/models/product.dart';

class ProductService {
  // Daftar produk yang tersedia di kafe
  final List<Product> _products = [
    // Minuman
    Product(
      name: "Cappuccino",
      price: 25000,
      image: "assets/menu/drink/Cappucino.png",
      category: ProductCategory.minuman,
      description: "Espresso klasik dengan steamed milk dan busa susu yang tebal. Sempurna untuk memulai hari Anda.",
    ),
    Product(
      name: "Kopi Susu Meow",
      price: 22000,
      image: "assets/cats/mam.jpg", // Menggunakan gambar kucing karena tidak ada kopi susu spesifik di menu/drink
      category: ProductCategory.minuman,
      description: "Kopi susu andalan kami dengan sentuhan rasa manis gula aren yang khas dan creamy.",
    ),
    Product(
      name: "Teh Hijau",
      price: 15000,
      image: "assets/menu/drink/teh_hijau.png",
      category: ProductCategory.minuman,
      description: "Teh hijau asli yang menenangkan, kaya akan antioksidan. Disajikan hangat atau dingin.",
    ),
    Product(
      name: "Jus Alpukat",
      price: 20000,
      image: "assets/menu/drink/jus_alpukat.png",
      category: ProductCategory.minuman,
      description: "Jus alpukat segar yang lembut dan mengenyangkan, dengan sedikit sentuhan manis.",
    ),

    // Makanan
    Product(
      name: "Nasi Goreng Paw",
      price: 28000,
      image: "assets/menu/food/nasi_goreng_paw.png",
      category: ProductCategory.makanan,
      description: "Nasi goreng spesial dengan bumbu rahasia, disajikan dengan telur mata sapi dan kerupuk.",
    ),
    Product(
      name: "Mie Kucing",
      price: 25000,
      image: "assets/cats/sicuki.jpg", // Menggunakan gambar kucing sebagai placeholder
      category: ProductCategory.makanan,
      description: "Mie goreng lezat dengan porsi pas, dimasak dengan sayuran segar dan topping pilihan.",
    ),
    Product(
      name: "Mie Ayam",
      price: 27000,
      image: "assets/menu/food/mie_ayam.jpg",
      category: ProductCategory.makanan,
      description: "Mie ayam lezat dengan topping ayam cincang, sawi, dan pangsit renyah.",
    ),
    Product(
      name: "Kentang Goreng",
      price: 18000,
      image: "assets/cats/sitoldon.jpg", // Menggunakan gambar kucing karena tidak ada kentang goreng spesifik di menu/food
      category: ProductCategory.makanan,
      description: "Kentang goreng renyah yang digoreng sempurna, disajikan dengan saus sambal dan mayones.",
    ),

    // Roti
    Product(
      name: "Croissant",
      price: 18000,
      image: "assets/menu/food/donat.jpg", // Menggunakan donat.jpg sebagai yang paling mendekati
      category: ProductCategory.roti,
      description: "Pastry renyah dan buttery dari Prancis. Nikmat disantap bersama kopi atau teh.",
    ),
    Product(
      name: "Croissant Cokelat",
      price: 20000,
      image: "assets/menu/food/Croissants_cokelat.png",
      category: ProductCategory.roti,
      description: "Croissant renyah dengan isian cokelat lumer di dalamnya. Manis dan memuaskan.",
    ),
    Product(
      name: "Roti Bakar Keju",
      price: 15000,
      image: "assets/menu/food/roti_bakar_keju.png",
      category: ProductCategory.roti,
      description: "Roti tawar yang dipanggang renyah dengan olesan mentega dan taburan keju melimpah.",
    ),

    // Es Krim
    Product(
      name: "Es Krim Vanilla",
      price: 15000,
      image: "assets/menu/food/es_krim_vanilla.png",
      category: ProductCategory.esKrim,
      description: "Es krim vanilla klasik yang lembut dan manis, cocok untuk segala suasana.",
    ),
    Product(
      name: "Es Krim Cokelat",
      price: 15000,
      image: "assets/menu/food/es_krim_cokelat.png",
      category: ProductCategory.esKrim,
      description: "Es krim cokelat pekat dengan rasa yang kaya, favorit semua orang.",
    ),
  ];

  // Fungsi untuk mengambil semua produk
  List<Product> getProducts() {
    return _products;
  }
}
