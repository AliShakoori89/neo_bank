import 'package:persian_datetime_picker/persian_datetime_picker.dart';

String convertShamsiToMiladiMethod(String year, String month){

  final jalaliDate = Jalali(
    int.parse(year),
    int.parse(month),
    1,
  );

  final gregorian = jalaliDate.toGregorian();

  final cardExpDate = DateTime.utc(
    gregorian.year,
    gregorian.month,
    gregorian.day,
  ).toIso8601String();

  return cardExpDate;


}