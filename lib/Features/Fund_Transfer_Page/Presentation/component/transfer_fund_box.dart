import 'package:flutter/material.dart';

import '../../../../Core/Convertor/thousands_separator_formatter.dart';
import '../../../../Core/Theme/app_colors.dart';

class TransferFundBox extends StatelessWidget {
  const TransferFundBox({super.key, required this.balanceController});

  final TextEditingController balanceController;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        height: 44,
        color: Theme.of(context).colorScheme.outline,
        child: Stack(
          alignment: Alignment.center,
          children: [
            TextFormField(
              controller: balanceController,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              keyboardType: TextInputType.number,
              inputFormatters: [
                ThousandsSeparatorFormatter(),
              ],
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                hintText: 'مبلغ انتقال',
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context)
                      .colorScheme
                      .surface,
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
            ),

            Positioned(
              left: 16,
              child: Text(
                'ریال',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context)
                      .colorScheme
                      .primaryFixed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
