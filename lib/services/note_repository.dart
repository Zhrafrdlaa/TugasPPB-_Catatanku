import 'package:flutter/material.dart';
import '../models/note_model.dart';

/// Repository Catatan (Konsep OOP Singleton & State Management)
/// Mengelola data catatan aplikasi dengan notifikasi pembaruan secara reaktif.
class NoteRepository extends ChangeNotifier {
  // Singleton Pattern
  static final NoteRepository _instance = NoteRepository._internal();
  factory NoteRepository() => _instance;

  NoteRepository._internal() {
    _notes = _generateInitialNotes();
  }

  late List<NoteModel> _notes;

  List<NoteModel> get notes => List.unmodifiable(_notes);

  /// Menghasilkan data awal sesuai dengan sampel tugas
  List<NoteModel> _generateInitialNotes() {
    return [
      const NoteModel(
        id: '1',
        title: 'Ide Aplikasi',
        content:
            'Ide untuk membuat aplikasi catatan sederhana dengan fitur kategori, warna, dan prioritas. Aplikasi ini dirancang untuk mencatat ide, rencana, dan hal penting sehari-hari secara fleksibel dan rapi.',
        category: 'Ide Aplikasi',
        date: '19 Oktober 2026',
        time: '09.30',
        priority: NotePriority.high,
        cardColor: Color(0xFFFEF3C7),
        icon: Icons.lightbulb_rounded,
      ),
      const NoteModel(
        id: '2',
        title: 'Rencana Mingguan',
        content:
            '1. Menyelesaikan prototype antarmuka mobile.\n2. Review rancangan responsivitas pada layar smartphone.\n3. Uji interaksi navigasi antar halaman.',
        category: 'Kerja',
        date: '18 Oktober 2026',
        time: '14.15',
        priority: NotePriority.medium,
        cardColor: Color(0xFFD1FAE5),
        icon: Icons.calendar_today_rounded,
      ),
      const NoteModel(
        id: '3',
        title: 'Catatan Kuliah',
        content:
            'Materi Pemrograman Mobile Lanjut:\n- Arsitektur OOP dan pemisahan layer UI.\n- Pembuatan custom widget reusable.\n- Desain konsisten Material 3.',
        category: 'Kuliah',
        date: '17 Oktober 2026',
        time: '10.00',
        priority: NotePriority.medium,
        cardColor: Color(0xFFEDE9FE),
        icon: Icons.school_rounded,
      ),
      const NoteModel(
        id: '4',
        title: 'Hal yang Perlu Dibeli',
        content:
            '- Buku catatan spiral ukuran A5\n- Pulpen gel hitam 0.5mm\n- Sticky notes warna pastel\n- Kopi bubuk arabika',
        category: 'Belanja',
        date: '16 Oktober 2026',
        time: '19.45',
        priority: NotePriority.low,
        cardColor: Color(0xFFFCE7F3),
        icon: Icons.shopping_bag_rounded,
      ),
      const NoteModel(
        id: '5',
        title: 'Jurnal Harian',
        content:
            'Hari ini berhasil menyelesaikan perancangan antarmuka aplikasi CatatanKu. Tampilannya terlihat rapi, bersih, dan navigasinya terasa sangat natural.',
        category: 'Jurnal Harian',
        date: '15 Oktober 2026',
        time: '21.00',
        priority: NotePriority.low,
        cardColor: Color(0xFFE0F2FE),
        icon: Icons.favorite_rounded,
      ),
    ];
  }

  /// Menambahkan catatan baru
  void addNote(NoteModel note) {
    _notes.insert(0, note);
    notifyListeners();
  }

  /// Menghapus catatan berdasarkan ID
  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  /// Mencari catatan berdasarkan kata kunci dan kategori
  List<NoteModel> filterNotes({String query = '', String category = 'all'}) {
    return _notes.where((note) {
      final matchesQuery = query.isEmpty ||
          note.title.toLowerCase().contains(query.toLowerCase()) ||
          note.content.toLowerCase().contains(query.toLowerCase());

      final matchesCategory = category == 'all' ||
          (category == 'penting' && note.priority == NotePriority.high) ||
          note.category.toLowerCase().contains(category.toLowerCase());

      return matchesQuery && matchesCategory;
    }).toList();
  }
}
