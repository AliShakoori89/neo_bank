import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../../../Core/Spacing/app_space.dart';
import '../../../../../../../../../Core/Theme/app_colors.dart';
import 'Component/custom_row.dart';

copyAndShare(context, String cardNumber, String cardDeposit){
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.5,
        minChildSize: 0.5,
        maxChildSize: 0.85,
        builder: (context, scrollController) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              controller: scrollController,
              children: [
                Row(
                  children: [
                    Text(
                      'اشتراک همه',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.splashGradiantColor2
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: (){
                        context.pop();
                      },
                    )
                  ],
                ),
                Divider(
                  color: AppColors.loginPageHintFontColor,
                ),
                AppSpace.heightSpace_32,
                Column(
                  children: [
                    customRow(cardNumber, 'شماره کارت'),
                    AppSpace.heightSpace_24,
                    customRow(cardDeposit, 'شماره حساب'),
                    AppSpace.heightSpace_24,
                    customRow('IR8025710000000014528', 'شماره شبا'),
                  ],
                )
              ],
            ),
          );
        },
      );
    },
  );

}