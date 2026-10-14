import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app_provider.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: const MyPortofolioApp(),
    ),
  );
}

class MyPortofolioApp extends StatelessWidget {
  const MyPortofolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final isDark = provider.isDarkMode;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'POLIJE Student Portfolio',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: provider.primaryColor,
          brightness: isDark ? Brightness.dark : Brightness.light,
        ),
        primaryColor: provider.primaryColor,
        scaffoldBackgroundColor: isDark
            ? const Color(0xFF0F172A)
            : const Color(0xFFF4F7FB),
        appBarTheme: AppBarTheme(
          backgroundColor: provider.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
        ),
      ),
      home: const MainScreen(),
    );
  }
}
