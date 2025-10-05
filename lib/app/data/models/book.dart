enum BookCategory {
  semua, // Untuk filter "Semua"
  anak,
  sains,
  sejarah,
  novel,
  lainnya, // Kategori default jika tidak ada yang cocok
}

class Book {
  final String title;
  final String author;
  final String image;
  final String synopsis;
  final BookCategory category; // Properti kategori baru
  final String? authorWebsiteUrl; // Properti baru: URL situs web penulis (opsional)

  Book({
    required this.title,
    required this.author,
    required this.image,
    required this.synopsis,
    this.category = BookCategory.lainnya, // Beri nilai default
    this.authorWebsiteUrl, // Inisialisasi properti baru
  });
}
