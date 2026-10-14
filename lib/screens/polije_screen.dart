import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/polije_data.dart';
import '../providers/app_provider.dart';

class PolijeScreen extends StatefulWidget {
  const PolijeScreen({super.key});

  @override
  State<PolijeScreen> createState() => _PolijeScreenState();
}

class _PolijeScreenState extends State<PolijeScreen> {
  late final PageController _pageController;
  int _selected = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.86);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _openSite() async {
    try {
      final ok = await launchUrl(
        Uri.parse(polijeWebsite),
        mode: LaunchMode.externalApplication,
      );
      if (!ok && mounted) _snack('Tidak dapat membuka situs POLIJE');
    } catch (_) {
      if (mounted) _snack('Tidak dapat membuka situs POLIJE');
    }
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  // ---------- Komponen kecil ----------
  Widget _sectionTitle(AppProvider provider, IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 10),
      child: Row(
        children: [
          Icon(icon, color: provider.primaryColor, size: 22),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 112,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 12.5))),
        ],
      ),
    );
  }

  // ---------- 1. Banner gradient (mengikuti warna tema) ----------
  Widget _buildBanner(AppProvider provider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: provider.headerGradient,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.school_outlined,
              color: Colors.white,
              size: 38,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            polijeNama,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            polijeTagline,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: const [
              _BannerChip('Diploma III'),
              _BannerChip('Sarjana Terapan'),
              _BannerChip('Magister Terapan'),
            ],
          ),
        ],
      ),
    );
  }

  // ---------- 2. Profil ----------
  Widget _buildProfil(AppProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 0,
        color: provider.softCardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.withOpacity(0.25)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                polijeProfil,
                style: TextStyle(fontSize: 13, height: 1.45),
              ),
              const Divider(height: 24),
              for (final row in polijeInfoUmum) _infoRow(row[0], row[1]),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- 3. Program studi: dropdown + PageView ----------
  Widget _buildJurusan(AppProvider provider) {
    final accent = provider.primaryColor;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DropdownButtonFormField<int>(
            value: _selected,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: 'Pilih jurusan / jalur',
              prefixIcon: Icon(Icons.layers_outlined, color: accent),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: accent, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            items: List.generate(
              daftarJurusan.length,
              (i) => DropdownMenuItem(
                value: i,
                child: Text(
                  daftarJurusan[i].nama,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            onChanged: (i) {
              if (i == null) return;
              _pageController.animateToPage(
                i,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: _pageController,
            itemCount: daftarJurusan.length,
            onPageChanged: (i) => setState(() => _selected = i),
            itemBuilder: (context, i) {
              final j = daftarJurusan[i];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Card(
                  elevation: 0,
                  color: provider.softCardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: j.milikku ? accent : Colors.grey.withOpacity(0.3),
                      width: j.milikku ? 1.5 : 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: accent.withOpacity(0.14),
                          child: Icon(j.icon, color: accent, size: 28),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                j.nama,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                j.rumpun,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              if (j.milikku) ...[
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: accent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'Terkait prodi saya',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        // Indikator halaman
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(daftarJurusan.length, (i) {
            final active = i == _selected;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 7,
              width: active ? 20 : 7,
              decoration: BoxDecoration(
                color: active ? accent : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
        const SizedBox(height: 6),
        Text(
          '${_selected + 1} dari ${daftarJurusan.length}',
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }

  // ---------- 4. Prodi saya ----------
  Widget _buildProdiSaya(AppProvider provider) {
    final accent = provider.primaryColor;
    final accent2 = provider.headerGradient.last;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent.withOpacity(0.16), accent2.withOpacity(0.10)],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: accent.withOpacity(0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.badge_outlined, color: accent),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    prodiNama,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              prodiDeskripsi,
              style: TextStyle(fontSize: 13, height: 1.45),
            ),
            const Divider(height: 22),
            _infoRow('Jurusan', prodiJurusan),
            _infoRow('Lokasi', prodiLokasi),
            _infoRow('Perguruan tinggi', polijeNama),
          ],
        ),
      ),
    );
  }

  // ---------- 5. Fasilitas & kegiatan (grid responsif) ----------
  Widget _buildKegiatan(AppProvider provider) {
    final accent = provider.primaryColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const spacing = 12.0;
          final cols = constraints.maxWidth > 520 ? 3 : 2;
          final w = (constraints.maxWidth - spacing * (cols - 1)) / cols;
          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: daftarKegiatan.map((k) {
              return Container(
                width: w,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: provider.softCardColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(k.icon, color: accent, size: 26),
                    const SizedBox(height: 8),
                    Text(
                      k.judul,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      k.deskripsi,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: Colors.grey,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Sumber: ${k.sumber}',
                      style: TextStyle(
                        fontSize: 10,
                        color: accent,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  // ---------- 6. Sumber & tombol ----------
  Widget _buildFooter(AppProvider provider) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: provider.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _openSite,
              icon: const Icon(Icons.open_in_new, size: 18),
              label: const Text('Kunjungi situs resmi polije.ac.id'),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Sumber informasi',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          for (final s in daftarSumber)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                '• $s',
                style: const TextStyle(fontSize: 10.5, color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBanner(provider),
              _sectionTitle(
                provider,
                Icons.account_balance_outlined,
                'Profil POLIJE',
              ),
              _buildProfil(provider),
              _sectionTitle(
                provider,
                Icons.menu_book_outlined,
                'Jurusan dan Jalur Studi',
              ),
              _buildJurusan(provider),
              _sectionTitle(
                provider,
                Icons.person_pin_outlined,
                'Program Studi Saya',
              ),
              _buildProdiSaya(provider),
              _sectionTitle(
                provider,
                Icons.celebration_outlined,
                'Fasilitas dan Kegiatan',
              ),
              _buildKegiatan(provider),
              const SizedBox(height: 24),
              _buildFooter(provider),
            ],
          ),
        ),
      ),
    );
  }
}

class _BannerChip extends StatelessWidget {
  final String label;
  const _BannerChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white38),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
