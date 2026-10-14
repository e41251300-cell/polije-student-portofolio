import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static const String _keyDarkMode = 'is_dark_mode';
  static const String _keyLanguage = 'selected_language';
  static const String _keyAccentColor = 'accent_color';

  // Dark mode
  static Future<void> setDarkMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyDarkMode, isDark);
  }

  static Future<bool> getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyDarkMode) ?? false;
  }

  // Bahasa (disimpan sebagai nama, contoh: 'Bahasa Indonesia' atau 'English')
  static Future<void> setLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguage, language);
  }

  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguage) ?? 'Bahasa Indonesia';
  }

  // Warna aksen
  static Future<void> setAccentColor(int colorValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyAccentColor, colorValue);
  }

  static Future<int?> getAccentColor() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyAccentColor);
  }
}
