import 'package:flutter/material.dart';

class CardFormatter {
  static void formatCardNumber(String value, TextEditingController controller) {
    String cleaned = value.replaceAll(' ', '');
    if (cleaned.length > 16) {
      cleaned = cleaned.substring(0, 16);
    }

    List<String> parts = [];
    for (int i = 0; i < cleaned.length; i += 4) {
      int end = i + 4;
      if (end > cleaned.length) {
        end = cleaned.length;
      }
      parts.add(cleaned.substring(i, end));
    }

    String formatted = parts.join(' ');
    if (formatted != controller.text) {
      controller.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }
}