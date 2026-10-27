# CatatanKu — Aplikasi Catatan Harian

CatatanKu adalah aplikasi catatan harian berbasis Flutter yang dikembangkan sebagai bagian dari **Tugas Individu 02 — Uji Pemahaman Fase 2: Perancangan (Design)**. Project ini berfokus pada perancangan dan implementasi antarmuka pengguna (UI) menggunakan Flutter dan Dart.

Aplikasi ini dirancang dengan tampilan yang sederhana, modern, dan intuitif agar pengguna dapat melihat serta mengelola catatan harian melalui antarmuka yang rapi dan mudah dipahami.

## Fitur dan Halaman

1. **Splash Screen** — Menampilkan logo dan nama aplikasi CatatanKu.
2. **Login Statis** — Menampilkan halaman login sebagai rancangan antarmuka tanpa autentikasi.
3. **Beranda** — Menampilkan daftar catatan harian pengguna.
4. **Tambah Catatan** — Menyediakan formulir untuk memasukkan judul, isi catatan, kategori, warna, dan prioritas.
5. **Detail Catatan** — Menampilkan informasi lengkap dari catatan yang dipilih.

## Teknologi

- Flutter
- Dart
- Visual Studio Code

## Tujuan Pengembangan

Project ini bertujuan untuk meningkatkan pemahaman dalam membangun UI aplikasi mobile menggunakan Flutter, menerapkan navigasi antar halaman, serta membuat desain antarmuka yang konsisten, rapi, dan responsif.

## Cara Menjalankan Aplikasi (Run)

Buka terminal di folder proyek ini:

```bash
cd Catatanku
```

### 1. Jalankan di Web Browser (Google Chrome)

```bash
flutter run -d chrome
```

### 2. Jalankan di Microsoft Edge

```bash
flutter run -d edge
```

### 3. Jalankan di Windows Desktop

```bash
flutter run -d windows
```

### 4. Jalankan di Android (Device / Emulator)

```bash
flutter run
```

## Arsitektur Kode & OOP

- **Models (`lib/models/`)**: `NoteModel`, `CategoryModel`, `NotePriority` (Enum)
- **Reusable Widgets (`lib/core/widgets/`)**: `CustomButton`, `CustomTextField`, `PriorityBadge`, `CategoryChip`, `NoteCard`
- **Theme & Constants (`lib/core/constants/`)**: `AppColors`, `AppTheme`
- **State Repository (`lib/services/`)**: `NoteRepository` (Singleton + ChangeNotifier)

Laporan lengkap tersedia di file [LAPORAN_TUGAS_02.md](LAPORAN_TUGAS_02.md).

## Catatan

Project ini berfokus pada implementasi frontend/UI sesuai ketentuan tugas. Fitur autentikasi, penyimpanan data permanen, dan integrasi backend tidak termasuk dalam cakupan awal kecuali dikembangkan lebih lanjut.
