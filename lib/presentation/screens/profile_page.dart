import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:apktes1/app/data/models/book.dart';
import 'package:apktes1/app/data/providers/borrow_provider.dart';
import 'package:apktes1/presentation/screens/home_screen.dart';
import 'package:apktes1/presentation/screens/login_screen.dart';
import 'package:apktes1/presentation/screens/settings_screen.dart';
import 'package:apktes1/presentation/screens/webview_screen.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  final String email;

  const ProfilePage({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // hapus semua data login
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  void _showReturnDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Kembalikan Buku"),
          content: Consumer<BorrowProvider>(
            builder: (context, borrowProvider, child) {
              if (borrowProvider.borrowedBooks.isEmpty) {
                return const SizedBox(
                  height: 50,
                  child: Center(child: Text("Tidak ada buku yang sedang dipinjam."))
                );
              }
              return SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: borrowProvider.borrowedBooks.length,
                  itemBuilder: (context, index) {
                    final book = borrowProvider.borrowedBooks[index];
                    return ListTile(
                      leading: Image.asset(book.image, width: 50, height: 50, fit: BoxFit.cover),
                      title: Text(book.title),
                      subtitle: Text(book.author),
                      trailing: ElevatedButton(
                        child: const Text("Kembalikan"),
                        onPressed: () {
                          borrowProvider.returnBook(book);
                          // Tidak perlu pop dialog di sini, Consumer akan rebuild UI
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${book.title} telah dikembalikan.")),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
          actions: [
            TextButton(
              child: const Text("Tutup"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Saya", style: TextStyle(fontWeight: FontWeight.w600)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Profil
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: theme.appBarTheme.backgroundColor ?? colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage("assets/cats/Cat.jpg"),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.name,
                    style: textTheme.titleLarge?.copyWith(
                      color: theme.appBarTheme.foregroundColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.email,
                    style: textTheme.bodyMedium?.copyWith(
                      color: theme.appBarTheme.foregroundColor?.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Statistik
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Consumer<BorrowProvider>(
                    builder: (context, borrowProvider, child) {
                      return _buildStatCard(
                        context,
                        title: "Books Borrowed",
                        value: borrowProvider.borrowedBooks.length.toString(),
                        icon: Icons.menu_book_rounded,
                        color: Colors.green,
                      );
                    },
                  ),
                  _buildStatCard(
                    context,
                    title: "Books Returned",
                    value: "0", // Placeholder, requires history feature
                    icon: Icons.check_circle_outline,
                    color: Colors.redAccent,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Tombol Aksi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(context, "Pinjam", Icons.book_outlined, () {
                    // Arahkan ke tab buku. Ini memerlukan state management yang lebih kompleks.
                    // Untuk saat ini, kita akan navigasi ke home screen.
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen(email: widget.email)));
                  }),
                  _buildActionButton(context, "Kembalikan", Icons.undo, _showReturnDialog),
                  _buildActionButton(context, "Cari", Icons.search, () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen(email: widget.email)));
                  }),
                  _buildActionButton(context, "Riwayat", Icons.history, () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Fitur Riwayat akan segera hadir!")),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Bagian General + Logout
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildMenuItem(context, "Pengaturan", Icons.settings, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingsScreen()),
                    );
                  }),
                  _buildMenuItem(context, "Ganti Password", Icons.lock, () {
                     ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Fitur Ganti Password akan segera hadir!")),
                    );
                  }),
                  _buildMenuItem(context, "Notifikasi", Icons.notifications, () {
                     ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Fitur Notifikasi akan segera hadir!")),
                    );
                  }),
                  _buildMenuItem(context, "Kebijakan Privasi", Icons.privacy_tip, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WebViewScreen(
                          title: "Kebijakan Privasi",
                          url: "https://www.google.com/policies/privacy/",
                        ),
                      ),
                    );
                  }),

                  // Logout Button
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 2, horizontal: 8),
                    leading: Icon(Icons.logout, color: colorScheme.error),
                    title: Text(
                      "Logout",
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () => _logout(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return Card(
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String label, IconData icon, VoidCallback onTap) {
    final theme = Theme.of(context);
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: theme.colorScheme.primary, size: 28),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
      ),
      trailing: Icon(Icons.chevron_right, color: theme.hintColor.withOpacity(0.5)),
      onTap: onTap,
    );
  }
}
