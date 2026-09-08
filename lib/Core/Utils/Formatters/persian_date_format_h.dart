import 'package:shamsi_date/shamsi_date.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

String formatPersianDateH(String isoDate) {
  final dateTime = DateTime.parse(isoDate).toLocal();

  final j = Jalali.fromDateTime(dateTime);

  final formatted =
      '${j.hour.toString().padLeft(2, '0')}:${j.minute.toString().padLeft(2, '0')}';

  return formatted.toPersianDigit();
}
