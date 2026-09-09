import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../Core/Theme/app_colors.dart';

class ShebaTextField extends StatelessWidget {
  const ShebaTextField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      maxLength: 29,
      inputFormatters: [
        ShebaInputFormatter(),
      ],
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'لطفاً شماره شبا را وارد کنید';
        }

        final sheba = ShebaInputFormatter.normalize(value);

        if (sheba.length != 26) {
          return 'شماره شبا باید ۲۴ رقم باشد';
        }

        return null;
      },
      decoration: InputDecoration(
        counterText: '',
        hintText: 'XXXXXXX XXXX XXXX XXX XXX XXXX',
        hintStyle: TextStyle(
          fontSize: 13,
          color: Colors.grey.shade500,
        ),
        suffixIcon: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Center(
            widthFactor: 1,
            child: Text(
              'IR',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
        filled: true,
        fillColor: Colors.grey.withAlpha(30),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context)
                .colorScheme
                .surfaceDim,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context)
                .colorScheme
                .surfaceDim,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.splashGradiantColor1,
          ),
        ),
      ),
      onChanged: onChanged,
    );
  }
}

class ShebaInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final normalized = normalize(newValue.text);

    // حداکثر 24 رقم بعد از IR
    final limited = normalized.length > 24
        ? normalized.substring(0, 24)
        : normalized;

    final formatted = _format(limited);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: formatted.length,
      ),
    );
  }

  static String normalize(String value) {
    String result = value.toUpperCase();

    // حذف IR
    result = result.replaceFirst(RegExp(r'^IR'), '');

    const persian = '۰۱۲۳۴۵۶۷۸۹';
    const arabic = '٠١٢٣٤٥٦٧٨٩';
    const english = '0123456789';

    for (int i = 0; i < 10; i++) {
      result = result.replaceAll(persian[i], english[i]);
      result = result.replaceAll(arabic[i], english[i]);
    }

    return result.replaceAll(RegExp(r'[^0-9]'), '');
  }

  String _format(String value) {
    if (value.isEmpty) {
      return '';
    }

    final parts = <String>[];

    for (int i = 0; i < value.length; i += 4) {
      final end = (i + 4 < value.length)
          ? i + 4
          : value.length;

      parts.add(value.substring(i, end));
    }

    return parts.join(' ');
  }
}