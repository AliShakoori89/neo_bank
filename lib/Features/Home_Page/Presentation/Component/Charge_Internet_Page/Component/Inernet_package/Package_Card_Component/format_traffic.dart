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
      return '${gb.toInt()} گیگابایت';
    }
    return '${gb.toStringAsFixed(1)} گیگابایت';
  }
  return '$trafficInt مگابایت';
}