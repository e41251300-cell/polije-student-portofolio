import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/portofolio_model.dart';

class DBHelper {
  static Database? _database;

  // Nama tabel ditulis SEKALI di sini, dipakai di semua query.
  static const String _table = 'portofolios';

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'portofolio.db');
    return await openDatabase(
      path,
      version: 3,
      onCreate: (db, version) async {
        await _createTable(db);
        await _seed(db);
      },
      // Masih tahap pengembangan: tabel lama (ejaan apa pun) dibuang
      // lalu dibuat ulang.
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('DROP TABLE IF EXISTS portfolios');
        await db.execute('DROP TABLE IF EXISTS portofolios');
        await _createTable(db);
        await _seed(db);
      },
    );
  }

  static Future<void> _createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $_table(
        id TEXT PRIMARY KEY,
        title TEXT,
        category TEXT,
        year TEXT,
        description TEXT,
        techStack TEXT,
        imagePath TEXT
      )
    ''');
  }

  // Data awal (minimal 5 karya). Hanya dibuat sekali saat database pertama dibuat.
  static Future<void> _seed(Database db) async {
    final seeds = [
      PortofolioItem(
        id: '1',
        title: 'Sistem Quality Control Kusuma Cantika',
        category: 'Web App',
        year: '2025',
        description: 'Web untuk memantau kualitas produk secara akurat.',
        techStack: 'HTML • CSS • JavaScript • Firebase',
      ),
      PortofolioItem(
        id: '2',
        title: 'Cashel Mobile App',
        category: 'Mobile App',
        year: '2026',
        description: 'Aplikasi mobile penjualan alat tulis secara online.',
        techStack: 'Flutter • Dart • Firebase',
      ),
      // TODO: ganti 3 data di bawah ini dengan karya aslimu.
      PortofolioItem(
        id: '3',
        title: 'ISI JUDUL KARYA 3',
        category: 'Web App',
        year: '2025',
        description: 'Isi deskripsi singkat karya 3.',
        techStack: 'Isi teknologi',
      ),
      PortofolioItem(
        id: '4',
        title: 'ISI JUDUL KARYA 4',
        category: 'Mobile App',
        year: '2025',
        description: 'Isi deskripsi singkat karya 4.',
        techStack: 'Isi teknologi',
      ),
      PortofolioItem(
        id: '5',
        title: 'ISI JUDUL KARYA 5',
        category: 'UI/UX Design',
        year: '2025',
        description: 'Isi deskripsi singkat karya 5.',
        techStack: 'Isi teknologi',
      ),
    ];

    for (final item in seeds) {
      await db.insert(_table, item.toMap());
    }
  }

  // CREATE
  static Future<int> insertPortfolio(PortofolioItem item) async {
    final db = await database;
    return await db.insert(
      _table,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // READ
  static Future<List<PortofolioItem>> getPortfolios() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_table);
    return List.generate(maps.length, (i) => PortofolioItem.fromMap(maps[i]));
  }

  // UPDATE
  static Future<int> updatePortfolio(PortofolioItem item) async {
    final db = await database;
    return await db.update(
      _table,
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  // DELETE
  static Future<int> deletePortfolio(String id) async {
    final db = await database;
    return await db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }
}
