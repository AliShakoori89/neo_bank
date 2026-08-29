import 'package:shamsi_date/shamsi_date.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

String formatPersianDateMD(String isoDate) {
  final dateTime = DateTime.parse(isoDate).toLocal();

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final inputDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

  if (inputDate == today) {
    return 'امروز';
  }

  if (inputDate == yesterday) {
    return 'دیروز';
  }

  final j = Jalali.fromDateTime(dateTime);

  final formatted =
      // '
      // ${j.year}/
      '${j.month.toString().padLeft(2, '0')}/${j.day.toString().padLeft(2, '0')}';

  return formatted.toPersianDigit();
}
