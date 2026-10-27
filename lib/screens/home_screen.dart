import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_theme.dart';
import '../core/utils/app_date.dart';
import '../core/widgets/category_chip.dart';
import '../core/widgets/note_card.dart';
import '../models/category_model.dart';
import '../models/note_model.dart';
import '../services/note_repository.dart';
import 'add_note_screen.dart';
import 'detail_note_screen.dart';

// Halaman 3: daftar catatan sebagai grid dua kolom.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NoteRepository _repository = NoteRepository();
  final TextEditingController _searchController = TextEditingController();

  String _selectedCategory = 'all';

  @override
  void initState() {
    super.initState();
    _repository.addListener(_refresh);
  }

  @override
  void dispose() {
    _repository.removeListener(_refresh);
    _searchController.dispose();
    super.dispose();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final notes = _repository.filterNotes(
      query: _searchController.text,
      category: _selectedCategory,
    );

    return Scaffold(
      backgroundColor: AppColors.paper,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const AddNoteScreen()),
        ),
        backgroundColor: AppColors.accent,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 26),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18),
            _buildHeader(),
            const SizedBox(height: 20),
            _buildSearchField(),
            const SizedBox(height: 16),
            _buildCategoryBar(),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Catatan Saya', style: AppTheme.label),
                  Text(
                    '${notes.length} catatan',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.inkSoft,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: notes.isEmpty
                  ? _buildEmptyState()
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 96),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        // Kartu ringkas, tinggi tetap.
                        mainAxisExtent: 150,
                      ),
                      itemCount: notes.length,
                      itemBuilder: (context, index) => NoteCard(
                        note: notes[index],
                        onTap: () => _openDetail(notes[index]),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Halo, Zahrah', style: AppTheme.heading),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.waving_hand_rounded,
                    size: 24,
                    color: Color(0xFFF5B400),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                AppDate.full(DateTime.now()),
                style: AppTheme.subHeading,
              ),
            ],
          ),
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.deep,
            ),
            child: const Center(
              child: Text(
                'Z',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        style: const TextStyle(fontSize: 14, color: AppColors.ink),
        decoration: InputDecoration(
          hintText: 'Cari judul, isi, atau kategori',
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 20,
            color: AppColors.inkFaint,
          ),
          suffixIcon: _searchController.text.isEmpty
              ? null
              : IconButton(
                  tooltip: 'Bersihkan',
                  icon: const Icon(Icons.close_rounded, size: 18),
                  color: AppColors.inkFaint,
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                ),
        ),
      ),
    );
  }

  Widget _buildCategoryBar() {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: CategoryModel.defaultCategories.length,
        itemBuilder: (context, index) {
          final category = CategoryModel.defaultCategories[index];
          return CategoryChip(
            label: category.name,
            icon: category.icon,
            isSelected: _selectedCategory == category.id,
            onTap: () => setState(() => _selectedCategory = category.id),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.sticky_note_2_outlined, size: 46, color: AppColors.inkFaint),
          SizedBox(height: 14),
          Text(
            'Catatan tidak ditemukan',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Coba kata kunci lain atau pilih kategori "Semua".',
            style: TextStyle(fontSize: 13, color: AppColors.inkSoft),
          ),
        ],
      ),
    );
  }

  void _openDetail(NoteModel note) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => DetailNoteScreen(note: note)),
    );
  }
}
