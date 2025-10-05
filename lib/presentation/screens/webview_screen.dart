import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;

  const WebViewScreen({super.key, required this.url, required this.title});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String? _errorMessage; // Tambahkan variabel untuk pesan error

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Anda bisa menambahkan indikator progres di sini jika diinginkan
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
              _errorMessage = null; // Hapus pesan error sebelumnya saat halaman mulai dimuat
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              _isLoading = false;
              _errorMessage = 'Error memuat halaman: ${error.description} (Kode: ${error.errorCode})';
              print('WebView Error: ${error.description} (Kode: ${error.errorCode})'); // Log error ke konsol
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            // Contoh: Mencegah navigasi ke YouTube
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          if (_errorMessage != null) // Tampilkan pesan error jika ada
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 16),
                ),
              ),
            )
          else // Jika tidak ada error, tampilkan WebView
            WebViewWidget(controller: _controller),
          if (_isLoading) // Tampilkan CircularProgressIndicator saat memuat
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
