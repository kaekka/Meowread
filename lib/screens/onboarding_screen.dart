import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OnboardingScreen extends StatefulWidget {
  final String email;
  const OnboardingScreen({super.key, required this.email});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> pages = [
    {
      "title": "Pustakapaw",
      "subtitle":
          "mau konsultasi dengan profesor kita? nikmati pelayanan terbaik dari kami!",
      "image": "assets/meng.jpg"
    },
    {
      "title": "Mengmam",
      "subtitle":
          "kamu mau nikmati kopi hangat dan camilan favorit? tinggal pesan saja nanti diantar",
      "image": "assets/mam.jpg"
    },
    {
      "title": "Meowread",
      "subtitle":
          "lihat buku apa saja yang sudah kamu baca!! pinjam buku kesukaanmu dengan mudah cuman di MEOWREAD aja!!",
      "image": "assets/pustakapaw.jpg"
    },
  ];

  // ✅ Ambil nama dari email
  String getUserName() {
    String name = widget.email.split("@")[0];
    if (name.isNotEmpty) {
      return name[0].toUpperCase() + name.substring(1);
    }
    return "User";
  }

  // ✅ Tentukan ucapan selamat berdasarkan jam
  String getGreeting() {
    int hour = int.parse(DateFormat('HH').format(DateTime.now()));
    if (hour >= 4 && hour < 12) {
      return "Selamat Pagi";
    } else if (hour >= 12 && hour < 15) {
      return "Selamat Siang";
    } else if (hour >= 15 && hour < 18) {
      return "Selamat Sore";
    } else {
      return "Selamat Malam";
    }
  }

  void nextPage() {
    if (_currentIndex < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (_currentIndex > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFD7CCC8), Color(0xFFF5F5F5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              // ✅ Greeting bar full width
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                color: Colors.brown,
                child: Center(
                  child: Text(
                    "${getGreeting()}, ${getUserName()} 👋",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // ✅ PageView dengan tombol panah
              Expanded(
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _controller,
                      itemCount: pages.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 250,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 149, 91, 70),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Image.asset(
                                    pages[index]["image"]!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                              Text(
                                pages[index]["title"]!,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                pages[index]["subtitle"]!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    // ✅ Tombol kiri
                    Positioned(
                      left: 10,
                      top: MediaQuery.of(context).size.height * 0.25,
                      child: IconButton(
                        onPressed: previousPage,
                        icon: const Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.brown.withOpacity(0.8),
                          shape: const CircleBorder(),
                        ),
                      ),
                    ),

                    // ✅ Tombol kanan
                    Positioned(
                      right: 10,
                      top: MediaQuery.of(context).size.height * 0.25,
                      child: IconButton(
                        onPressed: nextPage,
                        icon: const Icon(Icons.arrow_forward_ios),
                        color: Colors.white,
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.brown.withOpacity(0.8),
                          shape: const CircleBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ✅ Dots indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                  (index) => Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
                    width: _currentIndex == index ? 16 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color:
                          _currentIndex == index ? Colors.brown : Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),

              // ✅ Tombol Get Started
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      "/home",
                      arguments: widget.email,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
