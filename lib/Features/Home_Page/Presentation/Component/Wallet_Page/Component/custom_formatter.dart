import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomNumberFormatter extends TextEditingController {
  @override
  set text(String newText) {
    if (newText.isEmpty) {
      super.text = '';
      return;
    }

    // حذف همه کاراکترهای غیر عددی (اعداد و جداکننده هزارگان)
    String numericOnly = newText.replaceAll(RegExp(r'[^0-9]'), '');

    if (numericOnly.isEmpty) {
      super.text = '';
      return;
    }

    // تبدیل به عدد و فرمت کردن با جدا کننده هزارگان
    final number = int.parse(numericOnly);
    // استفاده از 'en' برای جداکننده کاما انگلیسی، سپس تبدیل به فارسی
    final formatter = NumberFormat('#,###', 'en_US');
    String formattedText = formatter.format(number);

    // تبدیل کاما انگلیسی به کاما فارسی برای نمایش بهتر
    formattedText = formattedText.replaceAll(',', '٬');

    super.text = formattedText;

    // حرکت کرسر به انتهای متن
    selection = TextSelection.fromPosition(
      TextPosition(offset: formattedText.length),
    );
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    // نمایش اعداد فارسی
    final text = value.text;
    final persianNumbers = _convertToPersianNumbers(text);

    // همچنین جداکننده هزارگان را هم به فارسی تبدیل کنید (اگر قبلاً تبدیل نشده)
    final finalText = persianNumbers.replaceAll(',', '٬');

    return TextSpan(
      text: finalText,
      style: style,
    );
  }

  String _convertToPersianNumbers(String text) {
    const englishNumbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const persianNumbers = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    String result = text;
    for (int i = 0; i < englishNumbers.length; i++) {
      result = result.replaceAll(englishNumbers[i], persianNumbers[i]);
    }
    return result;
  }

  // دریافت مقدار عددی خالص برای استفاده در منطق برنامه
  int get rawValue {
    if (text.isEmpty) return 0;
    // حذف همه چیز بجز اعداد
    String numericOnly = text.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(numericOnly) ?? 0;
  }
}