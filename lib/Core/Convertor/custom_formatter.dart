import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomNumberFormatter extends TextEditingController {
  CustomNumberFormatter({
    String? initialValue,
  }) {
    if (initialValue != null && initialValue.isNotEmpty) {
      setAmountFromString(initialValue);
    }
  }

  /// مقدار خام به صورت int
  int get rawValue {
    final normalized = _normalizeNumbers(text);
    return int.tryParse(normalized) ?? 0;
  }

  /// مقدار خام برای API
  String get rawText {
    return _normalizeNumbers(text);
  }

  String get apiValue => rawText;

  /// تنظیم مقدار و نمایش با جداکننده هزارگان و اعداد فارسی
  void setAmount(int value) {
    final formatted = _format(value);

    super.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: formatted.length,
      ),
    );
  }

  /// اگر مقدار String بود
  void setAmountFromString(String value) {
    final normalized = _normalizeNumbers(value);
    final number = int.tryParse(normalized) ?? 0;

    setAmount(number);
  }

  String _format(int value) {
    if (value == 0) {
      return '۰';
    }

    final formatter = NumberFormat('#,###', 'en_US');

    String result = formatter.format(value);

    // جداکننده انگلیسی → جداکننده فارسی
    result = result.replaceAll(',', '٬');

    // اعداد انگلیسی → فارسی
    return _toPersianNumbers(result);
  }

  String _normalizeNumbers(String value) {
    String result = value;

    const persianNumbers = '۰۱۲۳۴۵۶۷۸۹';
    const englishNumbers = '0123456789';

    for (int i = 0; i < persianNumbers.length; i++) {
      result = result.replaceAll(
        persianNumbers[i],
        englishNumbers[i],
      );
    }

    const arabicNumbers = '٠١٢٣٤٥٦٧٨٩';

    for (int i = 0; i < arabicNumbers.length; i++) {
      result = result.replaceAll(
        arabicNumbers[i],
        englishNumbers[i],
      );
    }

    return result.replaceAll(RegExp(r'[^0-9]'), '');
  }

  String _toPersianNumbers(String value) {
    const englishNumbers = '0123456789';
    const persianNumbers = '۰۱۲۳۴۵۶۷۸۹';

    String result = value;

    for (int i = 0; i < englishNumbers.length; i++) {
      result = result.replaceAll(
        englishNumbers[i],
        persianNumbers[i],
      );
    }

    return result;
  }
}