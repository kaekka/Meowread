import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:apktes1/app/services/auth_service.dart';
import 'package:apktes1/presentation/screens/home_screen.dart';
import 'package:apktes1/presentation/screens/login_screen.dart'; // Import LoginScreen
import 'package:apktes1/presentation/screens/onboarding_screen.dart';

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
    print("SplashScreen: initState called.");
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _scaleAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // Menggunakan addPostFrameCallback untuk memastikan build selesai sebelum navigasi
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("SplashScreen: addPostFrameCallback triggered.");
      _checkLoginStatus();
    });
  }

  Future<void> _checkLoginStatus() async {
    print("SplashScreen: _checkLoginStatus started.");
    // Tunggu animasi selesai agar tidak terlihat terburu-buru
    await Future.delayed(const Duration(seconds: 3));
    print("SplashScreen: Delay finished.");

    // Pastikan widget masih ada di tree sebelum menggunakan context
    if (!mounted) {
      print("SplashScreen: Widget not mounted, returning from _checkLoginStatus.");
      return;
    }

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      print("SplashScreen: AuthService instance obtained. Calling loadCurrentUser...");
      await authService.loadCurrentUser(); // Pastikan user dimuat sebelum cek
      print("SplashScreen: loadCurrentUser completed. Is logged in: ${authService.isLoggedIn}. Current user: ${authService.currentUser}");

      // Cek sekali lagi jika widget masih ada setelah proses async
      if (!mounted) {
        print("SplashScreen: Widget not mounted after async operation, returning.");
        return;
      }

      if (authService.isLoggedIn) {
        print("SplashScreen: User is logged in, navigating to HomeScreen.");
        // Jika sudah login, langsung ke HomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(email: authService.currentUser!),
          ),
        );
      } else {
        print("SplashScreen: User is NOT logged in, navigating to LoginScreen.");
        // Jika belum login, lanjutkan ke LoginScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    } catch (e, stacktrace) {
      print("SplashScreen: CRITICAL ERROR during login status check: $e");
      print("Stacktrace: $stacktrace");
      // Fallback to LoginScreen in case of any error
      if (mounted) {
        print("SplashScreen: Navigating to LoginScreen due to error.");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
  }

  @override
  void dispose() {
    print("SplashScreen: dispose called.");
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
    final theme = Theme.of(context);
    print("SplashScreen: build method called.");
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.colorScheme.primary.withOpacity(0.2), theme.colorScheme.background],
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
                isEven ? theme.colorScheme.onBackground.withOpacity(0.5) : theme.primaryColor.withOpacity(0.5),
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
                          color: theme.colorScheme.onBackground,
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
                          color: theme.colorScheme.onBackground.withOpacity(0.7),
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
