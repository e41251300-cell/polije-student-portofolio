import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'portofolio_screen.dart';
import 'polije_screen.dart';
import 'settings_screen.dart';
import 'add_portofolio_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    final pages = [
      HomeScreen(onSeeAll: () => setState(() => _currentIndex = 2)),
      const ProfileScreen(),
      const PortofolioScreen(),
      const PolijeScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'POLIJE Student Portfolio',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: provider.primaryColor,
      ),
      body: pages[_currentIndex],
      floatingActionButton: _currentIndex == 2
          ? FloatingActionButton(
              backgroundColor: provider.primaryColor,
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddPortofolioScreen(),
                  ),
                );
              },
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: provider.primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: provider.getText('home'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: provider.getText('profile'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.work),
            label: provider.getText('portfolio'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.school),
            label: provider.getText('polije'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: provider.getText('settings'),
          ),
        ],
      ),
    );
  }
}
