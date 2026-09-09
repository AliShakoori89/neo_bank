import 'package:flutter/material.dart';

class CustomNumberFormatter extends TextEditingController {
  CustomNumberFormatter({
    String? initialValue,
  }) {
    if (initialValue != null && initialValue.isNotEmpty) {
      text = initialValue;
    }
  }

  /// مقدار عددی واقعی برای استفاده در منطق برنامه
  ///
  /// مثال:
  /// ۱٬۲۳۴٬۵۶۷ -> 1234567
  int get rawValue {
    if (text.isEmpty) return 0;

    final normalized = _normalizeNumbers(text);

    return int.tryParse(normalized) ?? 0;
  }

  /// مقدار خام به صورت String
  ///
  /// مثال:
  /// ۱٬۲۳۴٬۵۶۷ -> "1234567"
  String get rawText {
    return _normalizeNumbers(text);
  }

  /// مقدار مناسب برای ارسال به API
  String get apiValue => rawValue.toString();

  String _normalizeNumbers(String value) {
    // اعداد فارسی → انگلیسی
    String result = value;

    const persianNumbers = '۰۱۲۳۴۵۶۷۸۹';
    const englishNumbers = '0123456789';

    for (int i = 0; i < persianNumbers.length; i++) {
      result = result.replaceAll(
        persianNumbers[i],
        englishNumbers[i],
      );
    }

    // اعداد عربی → انگلیسی
    const arabicNumbers = '٠١٢٣٤٥٦٧٨٩';

    for (int i = 0; i < arabicNumbers.length; i++) {
      result = result.replaceAll(
        arabicNumbers[i],
        englishNumbers[i],
      );
    }

    // حذف جداکننده‌ها و سایر کاراکترها
    result = result.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );

    return result;
  }
}