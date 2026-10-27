import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/widgets/category_chip.dart';
import '../core/widgets/note_card.dart';
import '../models/category_model.dart';
import '../models/note_model.dart';
import '../services/note_repository.dart';
import 'add_note_screen.dart';
import 'detail_note_screen.dart';

/// Halaman 3: Beranda (Daftar Catatan)
/// Menampilkan salam personal, kolom pencarian, filter kategori, daftar kartu catatan,
/// tombol aksi tambah catatan (FAB), serta bottom navigation bar.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NoteRepository _repository = NoteRepository();
  final TextEditingController _searchController = TextEditingController();

  String _selectedCategory = 'all';
  int _currentBottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _repository.addListener(_onRepositoryUpdated);
  }

  @override
  void dispose() {
    _repository.removeListener(_onRepositoryUpdated);
    _searchController.dispose();
    super.dispose();
  }

  void _onRepositoryUpdated() {
    if (mounted) setState(() {});
  }

  void _onCategorySelected(String categoryId) {
    setState(() {
      _selectedCategory = categoryId;
    });
  }

  void _openDetailNote(NoteModel note) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailNoteScreen(note: note),
      ),
    );
  }

  void _openAddNote() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddNoteScreen(),
      ),
    );
  }

  void _confirmDeleteNote(NoteModel note) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Catatan', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text('Apakah kamu yakin ingin menghapus catatan "${note.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.priorityHigh),
            onPressed: () {
              _repository.deleteNote(note.id);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Catatan "${note.title}" berhasil dihapus'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredNotes = _repository.filterNotes(
      query: _searchController.text,
      category: _selectedCategory,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text(
                            'Halo, Ahmadi',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                              letterSpacing: -0.3,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text('👋', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Apa yang ingin kamu catat hari ini?',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),

                  // Avatar Profil Bulat
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primaryLight, width: 1.5),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person_rounded,
                        color: AppColors.primaryDark,
                        size: 26,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar & Filter Action
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: 'Cari catatan...',
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textMuted,
                          ),
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: AppColors.textMuted,
                            size: 22,
                          ),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear, size: 18),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() {});
                                  },
                                )
                              : null,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 13),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Tombol Ikon Filter
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.tune_rounded,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                      onPressed: () {
                        // Quick filter reset
                        setState(() {
                          _selectedCategory = 'all';
                          _searchController.clear();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Filter dikembalikan ke default (Semua)'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Horizontal Categories Scroll
            SizedBox(
              height: 52,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                scrollDirection: Axis.horizontal,
                itemCount: CategoryModel.defaultCategories.length,
                itemBuilder: (context, index) {
                  final cat = CategoryModel.defaultCategories[index];
                  final isSelected = _selectedCategory == cat.id;

                  return CategoryChip(
                    label: cat.name,
                    icon: cat.icon,
                    isSelected: isSelected,
                    onTap: () => _onCategorySelected(cat.id),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // Note List Header / Count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Catatan Harian (${filteredNotes.length})',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    _selectedCategory == 'all' ? 'Semua Kategori' : 'Difilter',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Daftar Catatan List
            Expanded(
              child: filteredNotes.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.note_alt_outlined,
                            size: 64,
                            color: AppColors.textMuted.withValues(alpha: 0.5),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Tidak ada catatan ditemukan',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Coba gunakan kata kunci atau kategori lain.',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 80),
                      itemCount: filteredNotes.length,
                      itemBuilder: (context, index) {
                        final note = filteredNotes[index];
                        return NoteCard(
                          note: note,
                          onTap: () => _openDetailNote(note),
                          onDelete: () => _confirmDeleteNote(note),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // Floating Action Button (+) Tambah Catatan
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddNote,
        backgroundColor: AppColors.primary,
        elevation: 3,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(
            top: BorderSide(color: AppColors.border, width: 1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _currentBottomNavIndex,
          height: 65,
          backgroundColor: Colors.white,
          indicatorColor: AppColors.primary.withValues(alpha: 0.12),
          elevation: 0,
          onDestinationSelected: (index) {
            setState(() {
              _currentBottomNavIndex = index;
            });
            if (index == 1) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Menu Arsip (UI Statis)'), duration: Duration(seconds: 1)),
              );
            } else if (index == 2) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Menu Profil Pengguna (UI Statis)'), duration: Duration(seconds: 1)),
              );
            }
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: AppColors.textMuted),
              selectedIcon: Icon(Icons.home_rounded, color: AppColors.primary),
              label: 'Beranda',
            ),
            NavigationDestination(
              icon: Icon(Icons.archive_outlined, color: AppColors.textMuted),
              selectedIcon: Icon(Icons.archive_rounded, color: AppColors.primary),
              label: 'Arsip',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline_rounded, color: AppColors.textMuted),
              selectedIcon: Icon(Icons.person_rounded, color: AppColors.primary),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
