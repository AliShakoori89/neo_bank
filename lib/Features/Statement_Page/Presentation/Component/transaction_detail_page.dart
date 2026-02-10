import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Core/Const/persian_date_format_special_specific.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class TransactionDetailPage extends StatelessWidget {
  const TransactionDetailPage({
    super.key,
    required this.title,
    required this.transferAmount,
    required this.date,
    required this.description,
  });

  final String title;
  final String transferAmount;
  final String date;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Container(
        height: 44,
        margin: EdgeInsets.only(right: 30, left: 30),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.splashGradiantColor1,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.12)),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RotatedBox(
                quarterTurns: 90,
                child: Icon(
                  Icons.send,
                  color: Theme.of(
                    context,
                  ).elevatedButtonTheme.style?.iconColor?.resolve({}),
                ),
              ),
              AppSpace.widthSpace_8,
              Text(
                'ارسال رسید',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.appWhite,
                ),
              ),
            ],
          ),
          onPressed: () {},
        ),
      ),
      body: Column(
        children: [
          AppSpace.heightSpace_48,
          Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(Icons.close),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryFixed,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppSpace.widthSpace_5,
                    Text(
                      'وجه',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryFixed,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpace.heightSpace_240,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                transferAmount.seRagham().toPersianDigit(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
              ),
              AppSpace.widthSpace_5,
              Text(
                'ریال',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
              ),
            ],
          ),
          AppSpace.heightSpace_24,
          Text(
            persianDateFormatSpecialSpecific(DateTime.parse(date)),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          AppSpace.heightSpace_24,
          Container(
            margin: EdgeInsets.all(20),
            child: Text(description, textAlign: TextAlign.justify),
          ),
        ],
      ),
    );
  }
}
