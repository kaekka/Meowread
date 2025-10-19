import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apktes1/app/core/theme/app_theme.dart';
import 'package:apktes1/providers/user_provider.dart';
import 'package:apktes1/app/data/providers/theme_provider.dart';
import 'package:apktes1/app/data/providers/borrow_provider.dart';
import 'package:apktes1/app/data/providers/cart_provider.dart';
import 'package:apktes1/app/services/auth_service.dart';
import 'package:apktes1/presentation/screens/login_screen.dart';
import 'package:apktes1/presentation/screens/register_screen.dart';
import 'package:apktes1/presentation/screens/home_screen.dart';
import 'package:apktes1/presentation/screens/splash_screen.dart';
import 'package:apktes1/presentation/screens/welcome_screen.dart';
import 'package:apktes1/presentation/screens/onboarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BorrowProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Meowread Web',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          initialRoute: '/splash',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/splash':
                return MaterialPageRoute(builder: (_) => const SplashScreen());
              case '/onboarding':
                return MaterialPageRoute(builder: (_) => const OnboardingScreen());
              case '/welcome':
                return MaterialPageRoute(builder: (_) => const WelcomeScreen());
              case '/login':
                return MaterialPageRoute(builder: (_) => const LoginScreen());
              case '/register':
                return MaterialPageRoute(builder: (_) => const RegisterScreen());
              case '/home':
                final email = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (_) => HomeScreen(email: email),
                );
              default:
                return MaterialPageRoute(
                  builder: (_) => const Scaffold(
                    body: Center(child: Text("404 - Page not found")),
                  ),
                );
            }
          },
        );
      },
    );
  }
}
