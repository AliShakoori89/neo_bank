import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ThousandsSeparatorFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat(
    '#,###',
    'en_US',
  );

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // پاک شدن کامل فیلد
    if (newValue.text.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(
          offset: 0,
        ),
      );
    }

    // تبدیل اعداد فارسی و عربی به انگلیسی
    final normalized = _normalizeNumbers(
      newValue.text,
    );

    // اگر هیچ عددی وجود نداشت
    if (normalized.isEmpty) {
      return oldValue;
    }

    final number = int.tryParse(normalized);

    if (number == null) {
      return oldValue;
    }

    // سه رقم سه رقم
    //
    // 1234567
    // ↓
    // 1,234,567
    String formatted = _formatter.format(number);

    // جداکننده انگلیسی → جداکننده فارسی
    //
    // 1,234,567
    // ↓
    // 1٬234٬567
    formatted = formatted.replaceAll(
      ',',
      '٬',
    );

    // تبدیل اعداد انگلیسی به فارسی
    //
    // 1٬234٬567
    // ↓
    // ۱٬۲۳۴٬۵۶۷
    formatted = _toPersianNumbers(
      formatted,
    );

    // محاسبه موقعیت کرسر
    final cursorPosition = _calculateCursorPosition(
      oldText: newValue.text,
      newText: formatted,
      oldCursorPosition: newValue.selection.baseOffset,
    );

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: cursorPosition,
      ),
    );
  }

  // ------------------------------------------------------------
  // تبدیل اعداد فارسی و عربی به انگلیسی
  // ------------------------------------------------------------

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

    // فقط اعداد انگلیسی باقی بمانند
    result = result.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );

    return result;
  }

  // ------------------------------------------------------------
  // تبدیل اعداد انگلیسی به فارسی
  // ------------------------------------------------------------

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

  // ------------------------------------------------------------
  // محاسبه موقعیت کرسر
  // ------------------------------------------------------------

  int _calculateCursorPosition({
    required String oldText,
    required String newText,
    required int oldCursorPosition,
  }) {
    // اگر کرسر ابتدای متن است
    if (oldCursorPosition <= 0) {
      return 0;
    }

    // اگر کرسر انتهای متن است
    if (oldCursorPosition >= oldText.length) {
      return newText.length;
    }

    // متن قبل از کرسر
    final textBeforeCursor = oldText.substring(
      0,
      oldCursorPosition,
    );

    // تعداد اعداد قبل از کرسر
    final digitsBeforeCursor = _normalizeNumbers(
      textBeforeCursor,
    ).length;

    if (digitsBeforeCursor == 0) {
      return 0;
    }

    int digitCount = 0;

    for (int i = 0; i < newText.length; i++) {
      if (_isDigit(newText[i])) {
        digitCount++;

        if (digitCount == digitsBeforeCursor) {
          return i + 1;
        }
      }
    }

    return newText.length;
  }

  bool _isDigit(String character) {
    return RegExp(
      r'[۰-۹٠-٩0-9]',
    ).hasMatch(character);
  }
}