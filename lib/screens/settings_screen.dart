import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan Provider (Bukan MyPortofolioApp.of)
    final provider = Provider.of<AppProvider>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            provider.getText('app_appearance'),
            style: TextStyle(
              color: provider.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: provider.softCardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SwitchListTile(
                  title: Text(provider.getText('dark_mode')),
                  subtitle: Text(provider.getText('dark_mode_sub')),
                  secondary: const Icon(Icons.wb_sunny_outlined),
                  value: provider.isDarkMode,
                  activeColor: provider.primaryColor,
                  onChanged: (val) => provider.toggleDarkMode(val),
                ),
                const Divider(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    provider.getText('primary_color'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildColorOption(
                      provider,
                      const Color(0xFF6A1B9A),
                    ), // Ungu
                    _buildColorOption(
                      provider,
                      const Color(0xFF1E88E5),
                    ), // Biru
                    _buildColorOption(
                      provider,
                      const Color(0xFF00897B),
                    ), // Hijau Toska
                    _buildColorOption(
                      provider,
                      const Color(0xFFE65100),
                    ), // Oranye
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            provider.getText('notifications'),
            style: TextStyle(
              color: provider.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: provider.softCardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SwitchListTile(
              title: Text(provider.getText('notif_update')),
              subtitle: Text(provider.getText('notif_sub')),
              secondary: const Icon(Icons.notifications_outlined),
              value: true,
              activeColor: provider.primaryColor,
              onChanged: (val) {},
            ),
          ),
          const SizedBox(height: 16),
          Text(
            provider.getText('storage_lang'),
            style: TextStyle(
              color: provider.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: provider.softCardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.language),
                  title: Text(provider.getText('language')),
                  subtitle: Text(provider.selectedLanguage),
                  trailing: DropdownButton<String>(
                    value: provider.selectedLanguage,
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(
                        value: 'Bahasa Indonesia',
                        child: Text('Bahasa Indonesia'),
                      ),
                      DropdownMenuItem(
                        value: 'Bahasa Jawa',
                        child: Text('Bahasa Jawa'),
                      ),
                      DropdownMenuItem(
                        value: 'English',
                        child: Text('English'),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) provider.setLanguage(val);
                    },
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.cleaning_services_outlined),
                  title: Text(provider.getText('clear_cache')),
                  subtitle: const Text('Memori: 24.5 MB'),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: provider.primaryColor,
                    ),
                    onPressed: () {},
                    child: Text(
                      provider.getText('clear'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorOption(AppProvider provider, Color color) {
    bool isSelected = provider.primaryColor == color;
    return GestureDetector(
      onTap: () => provider.setPrimaryColor(color),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: color,
        child: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
      ),
    );
  }
}
