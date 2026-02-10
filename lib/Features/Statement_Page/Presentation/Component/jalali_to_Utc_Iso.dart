import 'package:shamsi_date/shamsi_date.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

DateTime jalaliToUtcDate(String persianDate) {
  final normalized = persianDate.toEnglishDigit();
  final parts = normalized.split('/');

  final jy = int.parse(parts[0]);
  final jm = int.parse(parts[1]);
  final jd = int.parse(parts[2]);

  final jalali = Jalali(jy, jm, jd);
  final gregorian = jalali.toGregorian();

  return DateTime.utc(
    gregorian.year,
    gregorian.month,
    gregorian.day,
  );
}

/// ⬇️⬇️ این دوتا دقیقاً اینجا اضافه می‌شن
DateTime startOfDay(DateTime d) =>
    DateTime.utc(d.year, d.month, d.day, 0, 0, 0);

DateTime endOfDay(DateTime d) =>
    DateTime.utc(d.year, d.month, d.day, 23, 59, 59, 999);
