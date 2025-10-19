import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apktes1/app/services/auth_service.dart';
import 'package:apktes1/presentation/screens/home_screen.dart';
import 'package:apktes1/presentation/screens/login_screen.dart';
import 'package:apktes1/presentation/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _dotsController;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();

    // Animasi logo
    _logoController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..forward();

    _fadeAnim =
        CurvedAnimation(parent: _logoController, curve: Curves.easeIn);
    _scaleAnim =
        CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack);

    // Animasi titik-tiga (loop)
    _dotsController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _goToOnboarding();
    });
  }

  // 🔸 Arahkan ke Onboarding setelah delay
  Future<void> _goToOnboarding() async {
    await Future.delayed(const Duration(seconds: 5)); // durasi splash tampil
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  // 🔸 Animasi titik-tiga lembut
  Widget _buildLoadingDots() {
    return AnimatedBuilder(
      animation: _dotsController,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (i) {
            double t = (_dotsController.value * 3) - i;
            double opacity = (t >= 0 && t < 1) ? 1 - t : 0.3;
            return Opacity(
              opacity: opacity,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5D4037), // warna coklat kopi
      body: AnimatedBuilder(
        animation: _logoController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnim,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // LOGO
                  ScaleTransition(
                    scale: _scaleAnim,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Image.asset(
                        "assets/Logo.png",
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  _buildLoadingDots(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
