import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget navHeader(BuildContext context, Widget widget) {
  return Container(
    height: 92,
    width: double.infinity,
    padding: const EdgeInsets.only(
      top: 40, // spacing-5xl (مثلاً)
      right: 24, // spacing-3xl
      bottom: 16, // spacing-lg
      left: 24, // spacing-3xl
    ),
    decoration: BoxDecoration(
      color: Theme.of(context).appBarTheme.backgroundColor,
      border: Border(
        bottom: BorderSide(
          color: Theme.of(context).colorScheme.surfaceDim,
          width: 1,
        ),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        widget,
        IconButton(
          icon: Icon(Icons.account_balance_wallet_outlined),
          onPressed: (){
            context.push('/wallet_page');
          },
        ),
      ],
    )

  );
}
