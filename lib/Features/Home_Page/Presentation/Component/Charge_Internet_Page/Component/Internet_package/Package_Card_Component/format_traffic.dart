import 'package:persian_number_utility/persian_number_utility.dart';

String formatTraffic(dynamic traffic) {
  int trafficInt;

  if (traffic is int) {
    trafficInt = traffic;
  } else if (traffic is String) {
    trafficInt = int.tryParse(traffic) ?? 0;
  } else {
    trafficInt = 0;
  }

  if (trafficInt >= 1024) {
    double gb = trafficInt / 1024;
    // اگر عدد صحیح است، بدون اعشار نشان بده
    if (gb == gb.toInt()) {
      return '${gb.toInt().toString().toPersianDigit()} گیگابایت';
    }
    return '${gb.toStringAsFixed(1).toString().toPersianDigit()} گیگابایت';
  }
  return '${trafficInt.toString().toPersianDigit()} مگابایت';
}