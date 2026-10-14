import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              color: provider.primaryColor,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                // Ganti bagian CircleAvatar ini:
                CircleAvatar(
                  radius: 42,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: const AssetImage(
                      'assets/img/niha.jpeg',
                    ), // Panggil foto profil kamu
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Niha Natus Sholikhah',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Mahasiswa Teknik Informatika • E41251300 • POLIJE',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: provider.softCardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_circle, color: provider.primaryColor),
                      const SizedBox(width: 8),
                      const Text(
                        'Tentang Saya',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Saya Niha Natus Sholikhah, mahasiswa Teknik Informatika Politeknik Negeri Jember yang berfokus pada pengembangan aplikasi Web & Mobile.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                  const Divider(height: 24),
                  Row(
                    children: [
                      Icon(Icons.share, color: provider.primaryColor),
                      const SizedBox(width: 8),
                      const Text(
                        'Kontak & Media Sosial',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildContactItem(
                    Icons.email,
                    'nihanatussholikhah@gmail.com',
                  ),
                  _buildContactItem(Icons.phone, '+62 877-5207-4465'),
                  _buildContactItem(Icons.code, 'github.com/e41251300-cell'),
                  _buildContactItem(
                    Icons.work,
                    'linkedin.com/in/nihanasholikhah',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
