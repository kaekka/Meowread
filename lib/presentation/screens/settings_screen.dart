import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart'; 
import 'package:apktes1/app/data/providers/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isNotificationEnabled = false;
  String _selectedLanguage = 'Indonesia';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isNotificationEnabled = prefs.getBool('notification_enabled') ?? false;
      _selectedLanguage = prefs.getString('language') ?? 'Indonesia';
    });
  }

  Future<void> _toggleNotificationSetting(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notification_enabled', value);
    setState(() {
      _isNotificationEnabled = value;
    });
  }

  Future<void> _changeLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
    setState(() {
      _selectedLanguage = language;
    });
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pilih Bahasa"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("Indonesia"),
                onTap: () {
                  _changeLanguage("Indonesia");
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text("English"),
                onTap: () {
                  _changeLanguage("English");
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeviceInfo() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String info = "Tidak dapat mengambil info perangkat.";

    try {
      if (Theme.of(context).platform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        info = "Android:\nModel: ${androidInfo.model}\nVersi OS: ${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt})\nBrand: ${androidInfo.brand}";
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        info = "iOS:\nModel: ${iosInfo.model}\nNama Produk: ${iosInfo.name}\nVersi OS: ${iosInfo.systemVersion}";
      } else if (Theme.of(context).platform == TargetPlatform.windows) {
        WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
        info = "Windows:\nNama Komputer: ${windowsInfo.computerName}\nNama Produk: ${windowsInfo.productName}\nVersi OS: ${windowsInfo.displayVersion}";
      } else if (Theme.of(context).platform == TargetPlatform.macOS) {
        MacOsDeviceInfo macOsInfo = await deviceInfo.macOsInfo;
        info = "macOS:\nModel: ${macOsInfo.model}\nNama Produk: ${macOsInfo.computerName}\nVersi OS: ${macOsInfo.osRelease}";
      } else if (Theme.of(context).platform == TargetPlatform.linux) {
        LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
        info = "Linux:\nNama ID: ${linuxInfo.id}\nNama Pretty: ${linuxInfo.prettyName}\nVersi: ${linuxInfo.version}";
      } else if (Theme.of(context).platform == TargetPlatform.fuchsia) { 
        info = "Fuchsia: Informasi tidak tersedia.";
      } else { 
        WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
        info = "Web Browser:\nNama Browser: ${webBrowserInfo.browserName.name}\nVersi: ${webBrowserInfo.appVersion}\nPlatform: ${webBrowserInfo.platform}";
      }
    } catch (e) {
      info = "Gagal mendapatkan info perangkat: $e";
    }

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Informasi Perangkat"),
          content: SingleChildScrollView(
            child: Text(info),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengaturan", style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Notifikasi"),
            subtitle: const Text("Atur preferensi notifikasi Anda"),
            secondary: Icon(Icons.notifications, color: colorScheme.primary),
            value: _isNotificationEnabled,
            onChanged: _toggleNotificationSetting,
          ),
          SwitchListTile(
            title: const Text("Mode Gelap"),
            subtitle: const Text("Aktifkan untuk tampilan yang lebih nyaman di malam hari"),
            secondary: Icon(Icons.dark_mode, color: colorScheme.primary),
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
          ListTile(
            title: const Text("Bahasa"),
            subtitle: Text(_selectedLanguage),
            leading: Icon(Icons.language, color: colorScheme.primary),
            onTap: _showLanguageDialog,
          ),
          ListTile(
            title: const Text("Info Perangkat"),
            subtitle: const Text("Lihat detail perangkat Anda"),
            leading: Icon(Icons.info_outline, color: colorScheme.primary),
            onTap: _showDeviceInfo, 
          ),
        ],
      ),
    );
  }
}
