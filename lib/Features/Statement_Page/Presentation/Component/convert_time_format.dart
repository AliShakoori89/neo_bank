import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

String changeTimeFormat(String value) {

  DateTime dateTime = DateTime.parse(value);
  Gregorian g = Gregorian(dateTime.year, dateTime.month, dateTime.day);
  Jalali g2j1 = g.toJalali();
  String formattedDate = '${'${g2j1.year}'.toPersianDigit()}${'/''${g2j1.month.toString().padLeft(2, '0')}'.toPersianDigit()}${'/''${g2j1.day.toString().padLeft(2, '0')}'.toPersianDigit()}';

  return formattedDate;
}