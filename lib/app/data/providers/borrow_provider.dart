import 'package:flutter/material.dart';
import 'package:apktes1/app/data/models/book.dart';

class BorrowProvider extends ChangeNotifier {
  // Daftar semua buku yang tersedia di perpustakaan
  final List<Book> _libraryBooks = [
    // Buku dari BookService sebelumnya
    Book(
      title: "Atomic Habits",
      author: "James Clear",
      image: "assets/books/atomic_habits.png", // Diperbarui ke assets/books/
      synopsis: "Sebuah buku yang mengubah cara pandang Anda terhadap kebiasaan. James Clear mengajarkan bagaimana perubahan-perubahan kecil dapat memberikan hasil yang luar biasa.",
      category: BookCategory.sains,
      authorWebsiteUrl: "https://jamesclear.com",
    ),
    Book(
      title: "Filosofi Kopi",
      author: "Dewi Lestari",
      image: "assets/books/filosofi_kopi.png", // Diperbarui ke assets/books/
      synopsis: "Kumpulan cerita dan prosa tentang kopi, cinta, dan kehidupan. Setiap tegukan kopi menyimpan sebuah cerita yang mendalam dan penuh makna.",
      category: BookCategory.novel,
      authorWebsiteUrl: "https://deelestari.com",
    ),
    Book(
      title: "Norwegian Wood",
      author: "Haruki Murakami",
      image: "assets/books/norwegian_wood.png", // Diperbarui ke assets/books/
      synopsis: "Sebuah novel nostalgia yang membawa pembaca ke dalam kisah cinta, kehilangan, dan pendewasaan di Tokyo pada akhir tahun 1960-an.",
      category: BookCategory.novel,
      authorWebsiteUrl: "https://www.harukimurakami.com",
    ),
    // Buku dari daftar sebelumnya
    Book(
      title: "Laskar Pelangi",
      author: "Andrea Hirata",
      image: "assets/books/laskar_pelangi.png", // Diperbarui ke assets/books/
      synopsis: "Kisah inspiratif tentang perjuangan anak-anak miskin di Belitung untuk meraih pendidikan.",
      category: BookCategory.novel,
      authorWebsiteUrl: "https://andreahirata.com",
    ),
    Book(
      title: "Bumi Manusia",
      author: "Pramoedya Ananta Toer",
      image: "assets/books/bumi_manusia.png", // Diperbarui ke assets/books/
      synopsis: "Novel epik yang menggambarkan perjuangan seorang pribumi di era kolonial Belanda.",
      category: BookCategory.sejarah,
      authorWebsiteUrl: "https://id.wikipedia.org/wiki/Pramoedya_Ananta_Toer",
    ),
    Book(
      title: "Ayat-Ayat Cinta",
      author: "Habiburrahman El Shirazy",
      image: "assets/books/Ayat-Ayat_Cinta.png", // Diperbarui ke assets/books/
      synopsis: "Kisah cinta dan perjuangan seorang mahasiswa Indonesia di Mesir dengan latar belakang Islam.",
      category: BookCategory.novel,
      authorWebsiteUrl: "https://www.habiburrahmanelshirazy.com",
    ),
    Book(
      title: "Dilan 1990",
      author: "Pidi Baiq",
      image: "assets/books/Dilan_1990.png", // Diperbarui ke assets/books/
      synopsis: "Kisah romansa remaja yang berlatar Bandung tahun 90-an, penuh dengan gombalan khas Dilan.",
      category: BookCategory.novel,
      authorWebsiteUrl: "https://pidibaiq.com",
    ),
    Book(
      title: "Negeri 5 Menara",
      author: "Ahmad Fuadi",
      image: "assets/books/Negeri_5_Menara.png", // Diperbarui ke assets/books/
      synopsis: "Kisah tentang enam santri dari berbagai daerah yang menuntut ilmu di pondok pesantren dan meraih mimpi.",
      category: BookCategory.novel,
      authorWebsiteUrl: "https://ahmadfuadi.com",
    ),
    Book(
      title: "Sang Pemimpi",
      author: "Andrea Hirata",
      image: "assets/books/Sang_Pemimpi.png", // Diperbarui ke assets/books/
      synopsis: "Sekuel dari Laskar Pelangi, mengisahkan perjuangan Ikal dan Arai mengejar pendidikan hingga ke Paris.",
      category: BookCategory.novel,
      authorWebsiteUrl: "https://andreahirata.com",
    ),
    Book(
      title: "Perahu Kertas",
      author: "Dee Lestari",
      image: "assets/books/Perahu_Kertas.png", // Diperbarui ke assets/books/
      synopsis: "Kisah tentang dua sahabat, Kugy dan Keenan, yang memiliki mimpi dan takdir yang saling terkait.",
      category: BookCategory.novel,
      authorWebsiteUrl: "https://deelestari.com",
    ),
  ];

  // Daftar buku yang sedang dipinjam oleh pengguna
  final List<Book> _borrowedBooks = [];

  // Inisialisasi beberapa buku sebagai sudah dipinjam untuk demonstrasi
  BorrowProvider() {
    // Pastikan _libraryBooks tidak kosong sebelum mencoba meminjam
    if (_libraryBooks.isNotEmpty) {
      // Cek apakah buku sudah ada di _borrowedBooks sebelum menambahkan
      if (!isBorrowed(_libraryBooks[0])) {
        _borrowedBooks.add(_libraryBooks[0]); // Atomic Habits
      }
      if (_libraryBooks.length > 1 && !isBorrowed(_libraryBooks[1])) {
        _borrowedBooks.add(_libraryBooks[1]); // Filosofi Kopi
      }
    }
  }

  List<Book> get libraryBooks => _libraryBooks; // Getter untuk semua buku di perpustakaan
  List<Book> get borrowedBooks => _borrowedBooks;

  // Cek apakah sebuah buku sudah dipinjam
  bool isBorrowed(Book book) {
    return _borrowedBooks.any((b) => b.title == book.title);
  }

  // Fungsi untuk meminjam buku
  void borrowBook(Book book) {
    if (!isBorrowed(book)) {
      _borrowedBooks.add(book);
      notifyListeners();
    }
  }

  // Fungsi untuk mengembalikan buku
  void returnBook(Book book) {
    _borrowedBooks.removeWhere((b) => b.title == book.title);
    notifyListeners();
  }
}
