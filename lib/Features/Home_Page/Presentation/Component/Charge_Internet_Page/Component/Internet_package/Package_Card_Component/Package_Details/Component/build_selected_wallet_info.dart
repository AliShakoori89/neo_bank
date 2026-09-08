import 'package:flutter/material.dart';

import '../../../../../../../../../../Core/Theme/app_colors.dart';

Widget buildSelectedWalletInfo(String selectedWalletTitle, VoidCallback selectWallet) {

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.splashGradiantColor1.withAlpha(10),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: AppColors.splashGradiantColor1.withAlpha(30),
      ),
    ),
    child: Row(
      children: [
        const Icon(Icons.account_balance_wallet,
            size: 20, color: Colors.green),
        const SizedBox(width: 8),
        Text(
          'کیف پول انتخاب شده: ',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        Text(
          selectedWalletTitle,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: selectWallet,
          child: const Text('تغییر'),
        ),
      ],
    ),
  );
}