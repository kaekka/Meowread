import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apktes1/app/data/models/book.dart';
import 'package:apktes1/app/data/providers/borrow_provider.dart';
import 'package:apktes1/presentation/screens/book_detail_screen.dart';

class BooksPage extends StatefulWidget {
  final String userName;
  const BooksPage({super.key, required this.userName});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  int _selectedCategoryIndex = 0;
  final List<String> _categoryLabels = ["Semua", "Anak", "Sains", "Sejarah", "Novel"];

  late Future<List<Book>> _booksFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _filterBooks();
  }

  void _filterBooks() {
    final borrowProvider = Provider.of<BorrowProvider>(context, listen: false);
    List<Book> allBooks = borrowProvider.libraryBooks;

    if (_selectedCategoryIndex == 0) {
      _booksFuture = Future.value(allBooks);
    } else {
      final selectedCategoryEnum = BookCategory.values.firstWhere(
        (e) => e.toString().split('.').last == _categoryLabels[_selectedCategoryIndex].toLowerCase(),
        orElse: () => BookCategory.lainnya,
      );
      _booksFuture = Future.value(allBooks.where((book) => book.category == selectedCategoryEnum).toList());
    }
    setState(() {});
  }

  void _showBorrowedBooksSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Consumer<BorrowProvider>(
          builder: (context, borrowProvider, child) {
            if (borrowProvider.borrowedBooks.isEmpty) {
              return const SizedBox(
                height: 150,
                child: Center(
                  child: Text("Tidak ada buku yang sedang Anda pinjam.", style: TextStyle(fontSize: 16))
                ),
              );
            }
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Buku yang Dipinjam (${borrowProvider.borrowedBooks.length})",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: borrowProvider.borrowedBooks.length,
                      itemBuilder: (context, index) {
                        final book = borrowProvider.borrowedBooks[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(book.image, width: 50, height: 50, fit: BoxFit.cover),
                            ),
                            title: Text(book.title, style: const TextStyle(fontWeight: FontWeight.w500)),
                            subtitle: Text(book.author),
                            trailing: ElevatedButton(
                              child: const Text("Kembalikan"),
                              onPressed: () {
                                borrowProvider.returnBook(book);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("${book.title} telah dikembalikan.")),
                                );
                                if (borrowProvider.borrowedBooks.isEmpty) {
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _categoryChip(String label, bool isActive, ThemeData theme) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = _categoryLabels.indexOf(label);
          _filterBooks();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? theme.primaryColor : theme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(22),
          boxShadow: isActive
              ? [BoxShadow(color: theme.primaryColor.withOpacity(0.25), blurRadius: 6, offset: const Offset(0, 3))]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : theme.colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _bookCard(Book book, ThemeData theme) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailScreen(book: book),
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: 'book-hero-${book.title}-${book.image}', 
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                  child: book.image.startsWith('http')
                      ? Image.network(book.image, fit: BoxFit.cover, width: double.infinity)
                      : Image.asset(book.image, fit: BoxFit.cover, width: double.infinity),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.author,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      final borrowProvider = Provider.of<BorrowProvider>(context, listen: false);
                      if (!borrowProvider.isBorrowed(book)) {
                        borrowProvider.borrowBook(book);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${book.title} berhasil dipinjam!")),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${book.title} sudah Anda pinjam.")),
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      alignment: Alignment.center,
                      height: 36,
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: theme.primaryColor.withOpacity(0.2),
                            offset: const Offset(0, 3),
                            blurRadius: 5,
                          )
                        ],
                      ),
                      child: Consumer<BorrowProvider>( 
                        builder: (context, borrowProvider, child) {
                          final isBookBorrowed = borrowProvider.isBorrowed(book);
                          return Text(
                            isBookBorrowed ? "Dipinjam" : "Pinjam",
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          );
                        },
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

  Widget _promoCard(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(right: 16),
      width: 280,
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Promo Spesial",
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: theme.primaryColor),
          ),
          const SizedBox(height: 6),
          Text(
            "Pinjam 3 buku sekaligus dan dapatkan waktu baca ekstra!",
            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.8)),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: const Text(
              "Pinjam",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Buku", style: TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          Consumer<BorrowProvider>(
            builder: (context, borrowProvider, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.bookmark_added_outlined, size: 28),
                    onPressed: _showBorrowedBooksSheet,
                  ),
                  if (borrowProvider.borrowedBooks.isNotEmpty)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Text(
                          borrowProvider.borrowedBooks.length.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: theme.primaryColor.withOpacity(0.3),
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
                    style: theme.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Selamat datang di Meowread ",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "Cari buku...",
                    hintStyle: TextStyle(color: theme.hintColor),
                    prefixIcon: Icon(Icons.search, color: theme.primaryColor),
                    filled: true,
                    fillColor: theme.cardColor,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: theme.primaryColor, width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categoryLabels.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 8),
                    itemBuilder: (context, index) => _categoryChip(
                      _categoryLabels[index],
                      _selectedCategoryIndex == index,
                      theme,
                    ),
                  ),
                ),
              ],
            ),

            
            const SizedBox(height: 24),
            Text(
              "Rekomendasi Buku Terbaru",
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            FutureBuilder<List<Book>>(
              future: _booksFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: theme.primaryColor));
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Tidak ada buku tersedia."));
                }
                final books = snapshot.data!;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: books.length,
                  itemBuilder: (context, index) => _bookCard(books[index], theme),
                );
              },
            ),

            const SizedBox(height: 24),

            
            Text(
              "Promo Spesial",
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(3, (_) => _promoCard(theme)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
