import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../models/portofolio_model.dart';
import '../providers/app_provider.dart';

class AddPortofolioScreen extends StatefulWidget {
  final PortofolioItem? itemToEdit;

  const AddPortofolioScreen({super.key, this.itemToEdit});

  @override
  State<AddPortofolioScreen> createState() => _AddPortofolioScreenState();
}

class _AddPortofolioScreenState extends State<AddPortofolioScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  late TextEditingController _titleController;
  late TextEditingController _descController;
  late TextEditingController _techController;

  String _selectedCategory = 'Mobile App';
  bool _isSaving = false;
  bool _saved = false;

  String? _imagePath; // foto yang sedang dipilih
  String? _originalImagePath; // foto asli saat mode edit

  final List<String> _categories = [
    'Mobile App',
    'Web App',
    'UI/UX Design',
    'AI / Machine Learning',
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.itemToEdit?.title ?? '',
    );
    _descController = TextEditingController(
      text: widget.itemToEdit?.description ?? '',
    );
    _techController = TextEditingController(
      text: widget.itemToEdit?.techStack ?? '',
    );
    if (widget.itemToEdit != null &&
        _categories.contains(widget.itemToEdit!.category)) {
      _selectedCategory = widget.itemToEdit!.category;
    }
    _originalImagePath = widget.itemToEdit?.imagePath;
    _imagePath = _originalImagePath;
  }

  @override
  void dispose() {
    // Kalau form ditutup tanpa menyimpan, buang foto baru yang sempat dipilih
    if (!_saved && _imagePath != null && _imagePath != _originalImagePath) {
      try {
        final f = File(_imagePath!);
        if (f.existsSync()) f.deleteSync();
      } catch (_) {}
    }
    _titleController.dispose();
    _descController.dispose();
    _techController.dispose();
    super.dispose();
  }

  Future<void> _deleteFile(String? path) async {
    if (path == null || path.isEmpty) return;
    try {
      final f = File(path);
      if (await f.exists()) await f.delete();
    } catch (_) {}
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: source,
        maxWidth: 1280,
        imageQuality: 80,
      );
      if (picked == null) return; // pengguna membatalkan

      // Salin ke penyimpanan internal aplikasi
      final dir = await getApplicationDocumentsDirectory();
      final imagesDir = Directory(p.join(dir.path, 'portofolio_images'));
      if (!await imagesDir.exists()) {
        await imagesDir.create(recursive: true);
      }
      final ext = p.extension(picked.path).isEmpty
          ? '.jpg'
          : p.extension(picked.path);
      final newPath = p.join(
        imagesDir.path,
        '${DateTime.now().millisecondsSinceEpoch}$ext',
      );
      await File(picked.path).copy(newPath);

      // Kalau sebelumnya sudah memilih foto baru (belum disimpan), buang yang lama
      if (_imagePath != null && _imagePath != _originalImagePath) {
        await _deleteFile(_imagePath);
      }

      if (!mounted) return;
      setState(() => _imagePath = newPath);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gagal mengambil foto: $e')));
    }
  }

  Future<void> _removeImage() async {
    if (_imagePath != null && _imagePath != _originalImagePath) {
      await _deleteFile(_imagePath);
    }
    if (!mounted) return;
    setState(() => _imagePath = null);
  }

  void _showSourceSheet() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Pilih dari Galeri'),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('Ambil dengan Kamera'),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    final provider = Provider.of<AppProvider>(context, listen: false);

    try {
      if (widget.itemToEdit == null) {
        // CREATE
        final newItem = PortofolioItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: _titleController.text.trim(),
          category: _selectedCategory,
          year: DateTime.now().year.toString(),
          description: _descController.text.trim(),
          techStack: _techController.text.trim(),
          imagePath: _imagePath,
        );
        await provider.addPortfolio(newItem);
      } else {
        // UPDATE
        final old = widget.itemToEdit!;
        final updatedItem = PortofolioItem(
          id: old.id,
          title: _titleController.text.trim(),
          category: _selectedCategory,
          year: old.year,
          description: _descController.text.trim(),
          techStack: _techController.text.trim(),
          imagePath: _imagePath,
        );
        await provider.updatePortfolio(old.id, updatedItem);

        // Foto lama sudah tidak dipakai, hapus filenya
        if (_originalImagePath != null && _originalImagePath != _imagePath) {
          await _deleteFile(_originalImagePath);
        }
      }
      _saved = true;
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gagal menyimpan: $e')));
    }
  }

  Widget _buildImagePicker(Color primary) {
    final hasImage = _imagePath != null && File(_imagePath!).existsSync();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Foto / Hasil Karya',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _showSourceSheet,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: hasImage
                  ? Image.file(
                      File(_imagePath!),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: primary.withOpacity(0.08),
                        border: Border.all(color: primary.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 40,
                            color: primary,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Ketuk untuk menambah foto',
                            style: TextStyle(color: primary),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
        if (hasImage)
          Row(
            children: [
              TextButton.icon(
                onPressed: _showSourceSheet,
                icon: const Icon(Icons.edit_outlined, size: 18),
                label: const Text('Ganti foto'),
              ),
              TextButton.icon(
                onPressed: _removeImage,
                icon: const Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: Colors.red,
                ),
                label: const Text(
                  'Hapus foto',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.itemToEdit == null ? 'Tambah Portofolio' : 'Edit Portofolio',
        ),
        backgroundColor: provider.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildImagePicker(provider.primaryColor),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul Proyek / Karya',
                ),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Kategori'),
                items: _categories
                    .map(
                      (cat) => DropdownMenuItem(value: cat, child: Text(cat)),
                    )
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedCategory = val);
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _techController,
                decoration: const InputDecoration(
                  labelText: 'Teknologi (contoh: Flutter • Dart)',
                ),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi Singkat',
                ),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: provider.primaryColor,
                ),
                onPressed: _isSaving ? null : _saveForm,
                child: _isSaving
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Simpan Portofolio',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
