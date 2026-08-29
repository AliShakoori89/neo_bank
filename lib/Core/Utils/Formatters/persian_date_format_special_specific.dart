import 'package:shamsi_date/shamsi_date.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

String persianDateFormatSpecialSpecific(DateTime date) {
  final j = Jalali.fromDateTime(date);

  const weekDays = [
    'دوشنبه',
    'سه‌شنبه',
    'چهارشنبه',
    'پنجشنبه',
    'جمعه',
    'شنبه',
    'یکشنبه',
  ];

  const months = [
    'فروردین',
    'اردیبهشت',
    'خرداد',
    'تیر',
    'مرداد',
    'شهریور',
    'مهر',
    'آبان',
    'آذر',
    'دی',
    'بهمن',
    'اسفند',
  ];

  final weekDay = weekDays[j.weekDay - 1];
  final month = months[j.month - 1];

  final hour = date.hour.toString().padLeft(2, '0');
  final minute = date.minute.toString().padLeft(2, '0');

  return '$weekDay '
          '${j.day} '
          '$month '
          '${j.year}    '
          '$hour:$minute'
      .toPersianDigit();
}
