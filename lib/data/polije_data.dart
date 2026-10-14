import 'package:flutter/material.dart';

// ============================================================
// Data halaman "Tentang POLIJE"
// Sumber utama: https://www.polije.ac.id (diakses 14 Oktober 2026)
// Semua teks ditulis ulang dengan kalimat sendiri.
// ============================================================

const String polijeWebsite = 'https://www.polije.ac.id';

// ---------- Profil ----------
const String polijeNama = 'Politeknik Negeri Jember';
const String polijeTagline = 'Pendidikan Vokasi • Jember, Jawa Timur';

const String polijeProfil =
    'Politeknik Negeri Jember (POLIJE) adalah perguruan tinggi vokasi. '
    'Proses belajarnya diarahkan pada keahlian dan keterampilan yang sesuai '
    'kebutuhan dunia kerja, serta menumbuhkan kemandirian berkarya dan '
    'berwirausaha berbasis IPTEKS.';

const List<List<String>> polijeInfoUmum = [
  ['Lokasi', 'Jember, Jawa Timur'],
  ['Jenjang', 'Diploma III, Sarjana Terapan, dan Magister Terapan'],
  ['Lama studi', '3 tahun, 4 tahun, dan 1,5 tahun'],
  ['Karakter vokasi', 'Beban praktikum dua kali lipat beban teori'],
  [
    'Tri Dharma',
    'Pendidikan dan Pengajaran, Penelitian dan Pengembangan, '
        'Pengabdian kepada Masyarakat',
  ],
  ['Visi jangka panjang', 'Menjadi politeknik terkemuka di Asia pada 2035'],
];

// ---------- Jurusan / Program Studi ----------
class Jurusan {
  final String nama;
  final String rumpun; // pengelompokan dari aplikasi agar mudah dibaca
  final IconData icon;
  final bool milikku;

  const Jurusan(this.nama, this.rumpun, this.icon, {this.milikku = false});
}

const List<Jurusan> daftarJurusan = [
  Jurusan(
    'Produksi Pertanian',
    'Pertanian & Agribisnis',
    Icons.agriculture_outlined,
  ),
  Jurusan(
    'Teknologi Pertanian',
    'Pertanian & Agribisnis',
    Icons.precision_manufacturing_outlined,
  ),
  Jurusan('Peternakan', 'Pertanian & Agribisnis', Icons.pets_outlined),
  Jurusan(
    'Manajemen Agribisnis',
    'Pertanian & Agribisnis',
    Icons.storefront_outlined,
  ),
  Jurusan(
    'Teknologi Informasi',
    'Teknologi & Teknik',
    Icons.computer_outlined,
    milikku: true,
  ),
  Jurusan('Teknik', 'Teknologi & Teknik', Icons.engineering_outlined),
  Jurusan(
    'Bahasa, Komunikasi dan Pariwisata',
    'Bisnis & Bahasa',
    Icons.translate_outlined,
  ),
  Jurusan('Bisnis', 'Bisnis & Bahasa', Icons.business_center_outlined),
  Jurusan('Kesehatan', 'Kesehatan', Icons.health_and_safety_outlined),
  Jurusan('Kelas Internasional', 'Jalur Khusus', Icons.public_outlined),
  Jurusan(
    'PSDKU',
    'Program Studi Di Luar Kampus Utama',
    Icons.location_city_outlined,
    milikku: true,
  ),
];

// ---------- Program studi saya ----------
// TODO: tambahkan detail prodi (kompetensi lulusan, dst.) dari halaman
// Jurusan > PSDKU atau Teknologi Informasi di polije.ac.id.
const String prodiNama = 'Teknik Informatika';
const String prodiJurusan = 'Teknologi Informasi';
const String prodiLokasi = 'PSDKU Kabupaten Nganjuk';
const String prodiDeskripsi =
    'Program Studi di Luar Kampus Utama (PSDKU) Politeknik Negeri Jember '
    'yang berlokasi di Kabupaten Nganjuk, di bawah Jurusan Teknologi Informasi.';

// ---------- Fasilitas & Kegiatan ----------
class Kegiatan {
  final String judul;
  final String deskripsi;
  final IconData icon;
  final String sumber;

  const Kegiatan(this.judul, this.deskripsi, this.icon, this.sumber);
}

const List<Kegiatan> daftarKegiatan = [
  Kegiatan(
    'Teaching Factory',
    'Pembelajaran berbasis proyek dengan proses yang mengacu pada standar industri.',
    Icons.factory_outlined,
    'greenmetric.ui.ac.id',
  ),
  Kegiatan(
    'Pameran Inovasi Mahasiswa',
    'Jurusan Kesehatan menggelar Final Mentions 2026 untuk memamerkan proyek mahasiswa.',
    Icons.lightbulb_outline,
    'kui.polije.ac.id',
  ),
  Kegiatan(
    'Pameran Produk PBL',
    'Jurusan Teknologi Pertanian menampilkan produk hasil Project-Based Learning.',
    Icons.inventory_2_outlined,
    'kui.polije.ac.id',
  ),
  Kegiatan(
    'Program GoGreen',
    'Kegiatan ramah lingkungan, seperti mengurangi emisi karbon dan memilah sampah.',
    Icons.eco_outlined,
    'greenmetric.ui.ac.id',
  ),
  Kegiatan(
    'Kantor Internasional',
    'Mendukung kerja sama global, termasuk kuliah tamu internasional.',
    Icons.language_outlined,
    'kui.polije.ac.id',
  ),
  Kegiatan(
    'Layanan Digital',
    'SIM Mahasiswa, E-Learning, dan layanan pengaduan tersedia di beranda situs.',
    Icons.devices_outlined,
    'polije.ac.id',
  ),
];

// ---------- Daftar sumber ----------
const List<String> daftarSumber = [
  'polije.ac.id, halaman Sekilas POLIJE dan menu Jurusan (diakses 14 Okt 2026)',
  'kui.polije.ac.id, Kantor Internasional POLIJE (diakses 14 Okt 2026)',
  'pasca.polije.ac.id, Program Pascasarjana POLIJE (diakses 14 Okt 2026)',
  'greenmetric.ui.ac.id, profil Politeknik Negeri Jember (diakses 14 Okt 2026)',
];
