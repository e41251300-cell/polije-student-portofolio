import 'package:flutter/material.dart';

import '../database/db_helper.dart';
import '../models/portofolio_model.dart';
import '../utils/pref_helper.dart';

class AppProvider extends ChangeNotifier {
  Color _primaryColor = const Color(0xFF2563EB);
  bool _isDarkMode = false;
  String _selectedLanguage = 'Bahasa Indonesia';

  List<PortofolioItem> _portfolios = [];
  bool _isLoading = true;
  String? _errorMessage;

  AppProvider() {
    _loadSettings();
    loadPortfolios();
  }

  // ---------- Getter ----------
  Color get primaryColor => _primaryColor;
  bool get isDarkMode => _isDarkMode;
  String get selectedLanguage => _selectedLanguage;
  List<PortofolioItem> get portfolios => _portfolios;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Warna kartu: putih bersih (terang) atau slate gelap (mode gelap)
  Color get softCardColor {
    if (_isDarkMode) return const Color(0xFF1E293B);
    return Colors.white;
  }

  // Warna gradient header: aksen utama menuju versi yang lebih terang
  List<Color> get headerGradient {
    final hsl = HSLColor.fromColor(_primaryColor);
    final lighter = hsl
        .withLightness((hsl.lightness + 0.18).clamp(0.0, 0.85))
        .toColor();
    return [_primaryColor, lighter];
  }

  // ---------- Pengaturan (tersimpan permanen) ----------
  Future<void> _loadSettings() async {
    try {
      _isDarkMode = await PrefHelper.getDarkMode();
      _selectedLanguage = await PrefHelper.getLanguage();
      final savedColor = await PrefHelper.getAccentColor();
      if (savedColor != null) _primaryColor = Color(savedColor);
      notifyListeners();
    } catch (e) {
      debugPrint('ERROR PREF LOAD: $e');
    }
  }

  Future<void> _safeSave(Future<void> Function() action) async {
    try {
      await action();
    } catch (e) {
      debugPrint('ERROR PREF SAVE: $e');
    }
  }

  void setPrimaryColor(Color color) {
    _primaryColor = color;
    notifyListeners();
    _safeSave(() => PrefHelper.setAccentColor(color.toARGB32()));
  }

  void toggleDarkMode(bool val) {
    _isDarkMode = val;
    notifyListeners();
    _safeSave(() => PrefHelper.setDarkMode(val));
  }

  void setLanguage(String lang) {
    _selectedLanguage = lang;
    notifyListeners();
    _safeSave(() => PrefHelper.setLanguage(lang));
  }

  // ---------- CRUD (tersambung ke SQLite) ----------
  Future<void> loadPortfolios() async {
    try {
      _errorMessage = null;
      _portfolios = await DBHelper.getPortfolios();
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('ERROR DATABASE: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addPortfolio(PortofolioItem item) async {
    try {
      await DBHelper.insertPortfolio(item);
    } catch (e) {
      debugPrint('ERROR INSERT: $e');
    }
    await loadPortfolios();
  }

  Future<void> updatePortfolio(String id, PortofolioItem newItem) async {
    try {
      await DBHelper.updatePortfolio(newItem);
    } catch (e) {
      debugPrint('ERROR UPDATE: $e');
    }
    await loadPortfolios();
  }

  Future<void> deletePortfolio(String id) async {
    try {
      await DBHelper.deletePortfolio(id);
    } catch (e) {
      debugPrint('ERROR DELETE: $e');
    }
    await loadPortfolios();
  }

  // ---------- Teks multi-bahasa ----------
  String getText(String key) {
    final translations = {
      'Bahasa Indonesia': {
        'home': 'Beranda',
        'profile': 'Profil',
        'portfolio': 'Portofolio',
        'polije': 'POLIJE',
        'settings': 'Pengaturan',
        'app_appearance': 'Tampilan & Warna Aplikasi',
        'dark_mode': 'Mode Gelap',
        'dark_mode_sub': 'Ganti latar ke hitam/gelap',
        'primary_color': 'Warna Utama Aplikasi',
        'notifications': 'Notifikasi',
        'notif_update': 'Notifikasi Update',
        'notif_sub': 'Aktif - Menerima kabar proyek baru',
        'storage_lang': 'Penyimpanan & Bahasa',
        'language': 'Bahasa',
        'clear_cache': 'Bersihkan Cache',
        'clear': 'Hapus',
      },
      'English': {
        'home': 'Home',
        'profile': 'Profile',
        'portfolio': 'Portfolio',
        'polije': 'POLIJE',
        'settings': 'Settings',
        'app_appearance': 'App Appearance & Color',
        'dark_mode': 'Dark Mode',
        'dark_mode_sub': 'Switch background to dark/black',
        'primary_color': 'App Primary Color',
        'notifications': 'Notifications',
        'notif_update': 'Update Notifications',
        'notif_sub': 'Active - Receive new project updates',
        'storage_lang': 'Storage & Language',
        'language': 'Language',
        'clear_cache': 'Clear Cache',
        'clear': 'Clear',
      },
    };
    return translations[_selectedLanguage]?[key] ??
        translations['Bahasa Indonesia']![key]!;
  }
}
