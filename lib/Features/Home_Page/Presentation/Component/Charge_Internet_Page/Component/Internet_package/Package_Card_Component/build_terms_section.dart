import 'package:flutter/material.dart';

Widget buildTermsSection(BuildContext context) {
  final theme = Theme.of(context);

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.amber.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.amber.withValues(alpha: 0.3),
      ),
    ),
    child: Row(
      children: [
        Icon(
          Icons.info_outline,
          color: Colors.amber[700],
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'پس از خرید، بسته به صورت خودکار فعال می‌شود. لطفاً از موجودی کافی حساب خود اطمینان حاصل کنید.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.amber[700],
            ),
          ),
        ),
      ],
    ),
  );
}
