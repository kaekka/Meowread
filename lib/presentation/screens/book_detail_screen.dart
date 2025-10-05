import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apktes1/app/data/models/book.dart';
import 'package:apktes1/app/data/providers/borrow_provider.dart';
import 'package:apktes1/presentation/screens/webview_screen.dart'; 

class BookDetailScreen extends StatelessWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.4,
            pinned: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 2,
            iconTheme: IconThemeData(color: theme.colorScheme.onBackground),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'book-hero-${book.title}-${book.image}', 
                child: book.image.startsWith('http')
                    ? Image.network(book.image, fit: BoxFit.cover)
                    : Image.asset(book.image, fit: BoxFit.cover),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Text(
                    book.title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "oleh ${book.author}",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 24),

                  
                  Text(
                    "Sinopsis",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    book.synopsis,
                    textAlign: TextAlign.justify,
                    style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                  ),
                  const SizedBox(height: 24),

                  
                  if (book.authorWebsiteUrl != null && book.authorWebsiteUrl!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Informasi Penulis",
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          leading: Icon(Icons.public, color: theme.primaryColor),
                          title: Text(
                            "Kunjungi Situs Web ${book.author}",
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WebViewScreen(
                                  title: "Situs Web ${book.author}",
                                  url: book.authorWebsiteUrl!,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),

                  const SizedBox(height: 120), 
                ],
              ),
            ),
          ),
        ],
      ),
      
      bottomSheet: Consumer<BorrowProvider>(
        builder: (context, borrowProvider, child) {
          final isBorrowed = borrowProvider.isBorrowed(book);
          return Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isBorrowed ? Colors.grey.shade600 : theme.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: isBorrowed
                  ? null 
                  : () {
                      borrowProvider.borrowBook(book);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${book.title} berhasil dipinjam!")),
                      );
                    },
              child: Text(
                isBorrowed ? "Sudah Dipinjam" : "Pinjam Buku",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
