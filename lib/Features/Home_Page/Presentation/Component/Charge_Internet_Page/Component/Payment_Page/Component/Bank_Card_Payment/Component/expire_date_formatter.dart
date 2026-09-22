import 'package:flutter/material.dart';

class ExpiryDateFormatter {
  static void formatExpiryDate(String value, TextEditingController controller) {
    String cleaned = value.replaceAll('/', '');
    if (cleaned.length > 4) {
      cleaned = cleaned.substring(0, 4);
    }

    if (cleaned.length >= 2) {
      String month = cleaned.substring(0, 2);
      String year = cleaned.length > 2 ? cleaned.substring(2) : '';
      String formatted = year.isNotEmpty ? '$month/$year' : month;

      if (formatted != controller.text) {
        controller.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
    } else {
      if (cleaned != controller.text) {
        controller.value = TextEditingValue(
          text: cleaned,
          selection: TextSelection.collapsed(offset: cleaned.length),
        );
      }
    }
  }
}