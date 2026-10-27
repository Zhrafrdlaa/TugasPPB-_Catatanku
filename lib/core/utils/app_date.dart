// Format tanggal Indonesia tanpa dependency intl.
class AppDate {
  AppDate._();

  static const List<String> _days = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  static const List<String> _months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  /// "Selasa, 27 Oktober 2026"
  static String full(DateTime date) =>
      '${_days[date.weekday - 1]}, ${date.day} ${_months[date.month - 1]} ${date.year}';

  /// "27 Oktober 2026"
  static String short(DateTime date) =>
      '${date.day} ${_months[date.month - 1]} ${date.year}';

  /// "19.30"
  static String clock(DateTime date) {
    final minute = date.minute.toString().padLeft(2, '0');
    return '${date.hour}.$minute';
  }
}
