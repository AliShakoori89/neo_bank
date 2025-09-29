import 'package:flutter/material.dart';
import '../../../../Core/Const/app_colors.dart';
import '../../../../Core/Const/app_space.dart';
import '../../../../Core/Utils/custom_card.dart';

Widget buildTransactionsList() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpace.heightSpace_16,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('آخرین تراکنش‌ها',
                style: TextStyle(
                    color: AppColors.homePageTitleColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
            Icon(Icons.arrow_forward_ios,
                color: AppColors.homePageTitleColor, size: 20),
          ],
        ),
        AppSpace.heightSpace_24,
        ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: const [
            CustomCard(
              deposit: true,
              title: 'واریز',
              subtitle: 'خلق ثروت سرزمین پارسه',
              date: 'پنجشنبه ۱۴۰۴/۰۴/۱۲',
              mount: '۲۳۲۴۵۳۰۰۰',
            ),
            AppSpace.heightSpace_16,
            CustomCard(
              deposit: true,
              title: 'تنظیمات امنیتی',
              subtitle: 'تغییر و دریافت رمز مجدد کارت',
              date: 'پنجشنبه ۱۴۰۴/۰۴/۱۲',
              mount: '۲۳۲۴۵۳۰۰۰',
            ),
            AppSpace.heightSpace_16,
            CustomCard(
              deposit: false,
              title: 'تعویض کارت',
              subtitle: 'می توانید کارت جدید سفارش دهید',
              date: 'پنجشنبه ۱۴۰۴/۰۴/۱۲',
              mount: '۲۳۲۴۵۳۰۰۰',
            ),
            AppSpace.heightSpace_16,
            CustomCard(
              deposit: false,
              title: 'غیر فعال کردن',
              subtitle: 'مسدودسازی کارت در صورت مفقودی و ...',
              circleColor: Colors.red,
              textColor: Colors.red,
              date: 'پنجشنبه ۱۴۰۴/۰۴/۱۲',
              mount: '۲۳۲۴۵۳۰۰۰',
            ),
            AppSpace.heightSpace_90,
          ],
        ),
      ],
    ),
  );
}