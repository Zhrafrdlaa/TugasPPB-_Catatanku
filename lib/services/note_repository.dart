import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/utils/app_date.dart';
import '../models/note_model.dart';

// Penyimpanan catatan (singleton). Semua halaman baca dari sini.
class NoteRepository extends ChangeNotifier {
  NoteRepository._internal();

  static final NoteRepository _instance = NoteRepository._internal();

  factory NoteRepository() => _instance;

  final List<NoteModel> _notes = _sampleNotes();

  // Tambah catatan di urutan paling atas.
  void addNote(NoteModel note) {
    _notes.insert(0, note);
    notifyListeners();
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  // Saring catatan berdasarkan kata kunci & kategori aktif.
  List<NoteModel> filterNotes({String query = '', String category = 'all'}) {
    final keyword = query.trim().toLowerCase();

    return _notes.where((note) {
      final matchesQuery = keyword.isEmpty ||
          note.title.toLowerCase().contains(keyword) ||
          note.content.toLowerCase().contains(keyword) ||
          note.category.toLowerCase().contains(keyword);

      final matchesCategory = switch (category) {
        'all' => true,
        'penting' => note.priority == NotePriority.high,
        _ => note.category.toLowerCase().contains(category),
      };

      return matchesQuery && matchesCategory;
    }).toList();
  }

  // Data contoh untuk tampilan awal.
  static List<NoteModel> _sampleNotes() {
    final today = DateTime.now();
    String dateAgo(int days) =>
        AppDate.short(today.subtract(Duration(days: days)));

    return [
      NoteModel(
        id: '1',
        title: 'Bayar Tagihan',
        content:
            '- Token listrik sebelum tanggal 25\n'
            '- Cuci motor yang udah menumpuk\n'
            '- Patungan Netflix sama Rani, transfer paling lambat besok',
        category: 'Penting',
        date: dateAgo(0),
        time: '08.15',
        priority: NotePriority.high,
        cardColor: AppColors.noteColors[0],
        icon: Icons.notifications_active_outlined,
      ),
      NoteModel(
        id: '2',
        title: 'Deadline Minggu Ini',
        content:
            'Kumpul makroekonomi Kamis jam 23.59, jangan lupa cantumin nama sama NIM '
            'di paling atas. Terus ada foto bukti presentasi yang harus di-print.',
        category: 'Kuliah',
        date: dateAgo(1),
        time: '16.40',
        priority: NotePriority.high,
        cardColor: AppColors.noteColors[2],
        icon: Icons.school_outlined,
      ),
      NoteModel(
        id: '3',
        title: 'Shift Kafe',
        content:
            '- Ganti shift hari Sabtu sama Dika\n'
            '- Bawa apron sama tumbler sendiri\n'
            '- Ngerjain laporan kas mingguan',
        category: 'Kerja',
        date: dateAgo(1),
        time: '11.05',
        priority: NotePriority.medium,
        cardColor: AppColors.noteColors[1],
        icon: Icons.work_outline,
      ),
      NoteModel(
        id: '4',
        title: 'Belanja Dapur',
        content:
            '- Telur 1 kg\n'
            '- Minyak goreng 2 liter\n'
            '- Kopi sachet yang tadi abis\n'
            '- Sayur buat masak 3 hari ke depan',
        category: 'Belanja',
        date: dateAgo(2),
        time: '19.30',
        priority: NotePriority.low,
        cardColor: AppColors.noteColors[3],
        icon: Icons.shopping_bag_outlined,
      ),
      NoteModel(
        id: '5',
        title: 'Mau Ditonton Nanti',
        content:
            'Nonton Look Back di bioskop, lanjutin episode One Piece yang ketunda, '
            'sama nyoba drakor rekomendasi Rani pas lagi gabut.',
        category: 'Pribadi',
        date: dateAgo(3),
        time: '21.10',
        priority: NotePriority.low,
        cardColor: AppColors.noteColors[4],
        icon: Icons.local_movies_outlined,
      ),
      NoteModel(
        id: '6',
        title: 'Catatan Hari Ini',
        content:
            'Dari sore hujan deres, akhirnya sempat beberes kamar yang udah '
            'kayak kapal karam. Besok mau nyoba resep nasi goreng yang dikasih ibu.',
        category: 'Jurnal Harian',
        date: dateAgo(4),
        time: '22.00',
        priority: NotePriority.low,
        cardColor: AppColors.noteColors[5],
        icon: Icons.favorite_outline,
      ),
    ];
  }
}
