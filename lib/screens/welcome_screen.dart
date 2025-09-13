import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int skipCount = 0;
  bool showSkip = true; // kontrol tombol skip

  Future<void> _handleSkip(BuildContext context) async {
    setState(() {
      skipCount++;
    });

    if (skipCount == 1) {
      // Pesan pertama
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: const Text(
              "😼 Hey, no☝️ no☝️ no☝️ yah, harus log in dulu!",
              textAlign: TextAlign.center,
            ),
          );
        },
      );
      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context).pop();
    } else if (skipCount == 2) {
      // Pesan kedua
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: const Text(
              "Serius harus log in dulu!!😠 atau aku ngambek, hmp! 😤",
              textAlign: TextAlign.center,
            ),
          );
        },
      );
      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context).pop();
    } else if (skipCount == 3) {
      // Pesan ketiga lalu langsung ke home
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: const Text(
              "😡 Aku marah kalau ga log in!! 😡",
              textAlign: TextAlign.center,
            ),
          );
        },
      );
      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context).pop();

      // tombol skip disembunyikan
      setState(() {
        showSkip = false;
      });

      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Bagian logo
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.45,
                decoration: BoxDecoration(
                  color: Colors.brown[200],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    "assets/Logo.png",
                    fit: BoxFit.contain,
                    height: 220,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Bagian teks
              Text(
                "Hi member, Meowread!!",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[800],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Jelajahi perpustakaan digital \nditemani kucing imut",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.brown[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Tombol login
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text("Log In"),
              ),
              const SizedBox(height: 15),

              // Tombol signup
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.brown,
                  minimumSize: const Size(200, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  side: const BorderSide(color: Colors.brown),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text("Sign Up"),
              ),
              const SizedBox(height: 20),

              // Tombol skip dengan animasi fade
              AnimatedOpacity(
                opacity: showSkip ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: showSkip
                    ? TextButton(
                        onPressed: () => _handleSkip(context),
                        child: Text(
                          "Skip Now",
                          style: GoogleFonts.poppins(
                            color: Colors.brown[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
