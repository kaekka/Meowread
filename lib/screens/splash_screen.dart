import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  final List<Alignment> pawAlignments = const [
    Alignment(-0.8, -0.9),
    Alignment(-0.4, -0.7),
    Alignment(0.2, -0.5),
    Alignment(0.7, -0.3),
    Alignment(-0.6, -0.1),
    Alignment(0.3, 0.1),
    Alignment(-0.2, 0.3),
    Alignment(0.6, 0.5),
    Alignment(-0.5, 0.7),
    Alignment(0.4, 0.9),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _scaleAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // ⬇️ ganti ke onboarding
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildPaw(Alignment alignment, int delay, Color color) {
    return Align(
      alignment: alignment,
      child: FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: _controller,
          curve: Interval(delay / 10, 1, curve: Curves.easeIn),
        )),
        child: Icon(
          Icons.pets,
          color: color,
          size: 28,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFD7CCC8), Color(0xFFFFF8E1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            ...List.generate(pawAlignments.length, (i) {
              final isEven = i % 2 == 0;
              return _buildPaw(
                pawAlignments[i],
                i + 1,
                isEven ? Colors.white : Colors.brown.shade300,
              );
            }),

            Center(
              child: ScaleTransition(
                scale: _scaleAnim,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/Logo.png",
                        height: 120, fit: BoxFit.contain),
                    const SizedBox(height: 20),
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: Text(
                        "Meowread 🐱",
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[800],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: Text(
                        "By Kaekka",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.brown[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
