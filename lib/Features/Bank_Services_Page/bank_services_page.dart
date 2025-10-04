import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Features/Bank_Services_Page/Presentation/Component/custom_icon_widget.dart';
import '../../Core/Const/app_colors.dart';
import '../../Core/Const/app_space.dart';
import '../../Core/Utils/custom_header.dart';

class BankServicesPage extends StatelessWidget {
  const BankServicesPage({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              // --- Header ---
          
              customHeader(context, Text('انتقال وجه',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.customHeaderTextColor
                ),
              )),
          
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
          
                    Text('واریز و پرداخت',
                      style: TextStyle(
                        color: AppColors.homePageTitleColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600
                      ),
                    ),
          
                    Container(
                      margin: EdgeInsets.only(
                        top: 16,
                        bottom: 16
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromRGBO(10, 13, 18, 0.05),
                            offset: const Offset(0, 1), // x=0, y=1
                            blurRadius: 2, // همون blur
                            spreadRadius: 0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12),
                        border: BoxBorder.all(
                          color: AppColors.homePageDividerColor,
                          width: 1,
                        )
                      ),
                      child: GridView.count(
                        shrinkWrap: true, // تا ارتفاع درست حساب بشه
                        physics: NeverScrollableScrollPhysics(), // چون داخل صفحه دیگه‌ای هست
                        crossAxisCount: 4, // تعداد ستون‌ها = 4
                        padding: EdgeInsets.all(
                          12
                        ),
                        mainAxisSpacing: 20,
                        children: [
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/switch-vertical.svg', iconName: 'انتقال وجه'),
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/globe.svg', iconName: 'اینترنت'),
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/simcard.svg', iconName: 'شارژ'),
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/gift.svg', iconName: 'تقویم مالی'),
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/receipt.svg', iconName: 'قبض'),
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/passcode.svg', iconName: 'انتقال شناسه دار'),
                        ],
                      )
                      ,
                    ),
          
                    AppSpace.heightSpace_4,
          
                    Text('امور حسابتان را آنلاین انجام دهید',
                      style: TextStyle(
                          color: AppColors.homePageTitleColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600
                      ),
                    ),
          
                    Container(
                      margin: EdgeInsets.only(
                          top: 16,
                          bottom: 16
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromRGBO(10, 13, 18, 0.05),
                              offset: const Offset(0, 1), // x=0, y=1
                              blurRadius: 2, // همون blur
                              spreadRadius: 0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12),
                          border: BoxBorder.all(
                            color: AppColors.homePageDividerColor,
                            width: 1,
                          )
                      ),
                      child: GridView.count(
                        shrinkWrap: true, // تا ارتفاع درست حساب بشه
                        physics: NeverScrollableScrollPhysics(), // چون داخل صفحه دیگه‌ای هست
                        crossAxisCount: 4, // تعداد ستون‌ها = 4
                        padding: EdgeInsets.all(
                            12
                        ),
                        mainAxisSpacing: 20,
                        children: [
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/switch-vertical.svg', iconName: 'افتتاح حساب جدید'),
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/credit-card.svg', iconName: 'حساب و کارت'),
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/calendar.svg', iconName: 'تقویم مالی'),
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/credit-card-plus.svg', iconName: 'صدور کارت'),
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/credit-card-x.svg', iconName: 'مسدودی کارت'),
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/passcode.svg', iconName: 'تبدیل کارت به شبا'),
                        ],
                      ),
                    ),

                    AppSpace.heightSpace_4,

                    Text('چک و وام خود را مدیریت کنید',
                      style: TextStyle(
                          color: AppColors.homePageTitleColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(
                          top: 16,
                          bottom: 16
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromRGBO(10, 13, 18, 0.05),
                              offset: const Offset(0, 1), // x=0, y=1
                              blurRadius: 2, // همون blur
                              spreadRadius: 0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12),
                          border: BoxBorder.all(
                            color: AppColors.homePageDividerColor,
                            width: 1,
                          )
                      ),
                      child: GridView.count(
                        shrinkWrap: true, // تا ارتفاع درست حساب بشه
                        physics: NeverScrollableScrollPhysics(), // چون داخل صفحه دیگه‌ای هست
                        crossAxisCount: 4, // تعداد ستون‌ها = 4
                        padding: EdgeInsets.all(
                            12
                        ),
                        mainAxisSpacing: 20,
                        children: [
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/coins-hand.svg', iconName: 'درخواست وام'),
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/wallet.svg', iconName: 'وام من'),
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/calculator.svg', iconName: 'معدل حساب'),
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/shuffle.svg', iconName: 'انتقال امتیاز وام'),
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/ticket.svg', iconName: 'چک های من'),
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/edit.svg', iconName: 'چک صیادی'),
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/passcode.svg', iconName: 'اقساط دیگران'),
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/passcode.svg', iconName: 'اعتبار سنجی'),
                        ],
                      ),
                    ),

                    AppSpace.heightSpace_4,

                    Text('با ما همراه باشید',
                      style: TextStyle(
                          color: AppColors.homePageTitleColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(
                          top: 16,
                          bottom: 16
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromRGBO(10, 13, 18, 0.05),
                              offset: const Offset(0, 1), // x=0, y=1
                              blurRadius: 2, // همون blur
                              spreadRadius: 0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12),
                          border: BoxBorder.all(
                            color: AppColors.homePageDividerColor,
                            width: 1,
                          )
                      ),
                      child: GridView.count(
                        shrinkWrap: true, // تا ارتفاع درست حساب بشه
                        physics: NeverScrollableScrollPhysics(), // چون داخل صفحه دیگه‌ای هست
                        crossAxisCount: 4, // تعداد ستون‌ها = 4
                        padding: EdgeInsets.all(
                            12
                        ),
                        mainAxisSpacing: 20,
                        children: [
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/file-heart.svg', iconName: 'همیارانر مهر'),
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/marker-pin.svg', iconName: 'شعب بانک'),
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/simcard.svg', iconName: 'سجام'),
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/film.svg', iconName: 'کلیپت'),
                          CustomIconWidget(iconPath: 'assets/svg/bank_services_page/dots-horizontal.svg', iconName: 'سایر خدمات'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),



              AppSpace.heightSpace_90
          
          
            ],
          ),
        )
      ),
    );
  }
}
