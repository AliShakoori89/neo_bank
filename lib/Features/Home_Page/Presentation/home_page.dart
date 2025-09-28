import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../Core/Const/app_colors.dart';
import '../../../Core/Const/app_space.dart';
import '../../../Core/Utils/custom_card.dart';
import '../../../Core/Utils/neo_bank_logo.dart';
import '../../Menu_Page/Presentation/Component/slider_image.dart';
import 'Component/add_card_button.dart';
import 'Component/custom_Indicator.dart';
import 'Component/custom_header.dart';
import 'Component/custom_icon.dart';
import 'Component/icon_row_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselSliderController _controller = CarouselSliderController();
  final CarouselSliderController _controller1 = CarouselSliderController();
  int _current = 0;
  int _current1 = 0;

  final List<Map<String, String>> sampleCard = [
    {'card_number': '6063732514168589', 'card_expire_date': '08/06'},
    {'card_number': '5022291075418596', 'card_expire_date': '11/27'},
  ];

  final List<Map<String, String>> sampleCard2 = [
    {
      'card_title': 'تسهیلات فوری تا سقف',
      'card_value': '100000000',
      'card_image': 'assets/image/banking-finance-bank-money.png',
    },
    {
      'card_title': 'تسهیلات فوری تا سقف',
      'card_value': '200000000',
      'card_image': 'assets/image/banking-finance-bank-money.png',
    },
    {
      'card_title': 'تسهیلات فوری تا سقف',
      'card_value': '300000000',
      'card_image': 'assets/image/banking-finance-bank-money.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildHeader(),
              _buildCardSlider(context),
              buildIconRow(),
              _buildSecondSlider(),
              _buildTransactionsList(),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 اسلایدر کارت‌ها + بک‌گراند
  Widget _buildCardSlider(BuildContext context) {
    final List<Widget> cardItems = [
      ...sampleCard.map((card) => _buildBankCard(card)),
      buildAddCardButton(context),
    ];

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.splashGradiantColor2,
                AppColors.splashGradiantColor2,
                const Color(0xff058eb5),
                AppColors.splashGradiantColor2,
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 200,
                child: CarouselSlider(
                  items: cardItems,
                  carouselController: _controller,
                  options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      setState(() => _current = index);
                    },
                  ),
                ),
              ),
              buildIndicator(cardItems.length, _current),
            ],
          ),
        ),
      ],
    );
  }

  /// 🔹 کارت بانکی
  Widget _buildBankCard(Map<String, String> card) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: AppColors.appWhite),
        borderRadius: BorderRadius.circular(20),
        color: AppColors.splashGradiantColor2,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 20, 20),
        child: Column(
          children: [
            _buildCardHeader(),
            const Spacer(),
            _buildCardNumberAndDate(card),
            AppSpace.heightSpace_12,
            _buildCardBalance(),
          ],
        ),
      ),
    );
  }

  /// 🔹 اسلایدر دوم
  Widget _buildSecondSlider() {
    final cardItems2 = sampleCard2
        .map((card) => Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: AppColors.appWhite),
        borderRadius: BorderRadius.circular(20),
        color: AppColors.splashGradiantColor1,
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(card['card_title'] ?? '',
                  style: TextStyle(
                      fontSize: 14,
                      color: AppColors.appWhite,
                      fontWeight: FontWeight.w600)),
              Text('${card['card_value']}'.seRagham().toPersianDigit(),
                  style: TextStyle(
                      fontSize: 20,
                      color: AppColors.appWhite,
                      fontWeight: FontWeight.w700)),
            ],
          ),
          Image.asset(card['card_image'] ?? '',
              width: 78, height: 54),
        ],
      ),
    ))
        .toList();

    return SizedBox(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Stack(
          children: [
            CarouselSlider(
              items: cardItems2,
              carouselController: _controller1,
              options: CarouselOptions(
                height: 120,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() => _current1 = index);
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 10
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    cardItems2.length,
                        (index) => Container(
                      width: 24,
                      height: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: _current1 == index
                            ? AppColors.appWhite
                            : AppColors.splashGradiantColor2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 لیست تراکنش‌ها
  Widget _buildTransactionsList() {
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

  /// 🔹 بخش‌های داخلی کارت
  Widget _buildCardHeader() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
    child: Row(
      children: [
        SizedBox(
          width: 94,
          height: 24,
          child: SvgPicture.asset(
            'assets/svg/Union.svg',
            colorFilter:
            const ColorFilter.mode(AppColors.appWhite, BlendMode.srcIn),
          ),
        ),
        const Spacer(),
        Image.asset('assets/logo/Logomark.png',
            width: 27, height: 25, color: AppColors.appWhite),
      ],
    ),
  );

  Widget _buildCardNumberAndDate(Map<String, String> card) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Row(
      children: [
        Text(
          (card['card_number'] ?? '').replaceAllMapped(
            RegExp(r".{1,4}"),
                (match) => "${match.group(0)} ".toPersianDigit(),
          ),
          style: const TextStyle(color: AppColors.appWhite, fontSize: 14),
        ),
        const Spacer(),
        Text('${card['card_expire_date']}'.toPersianDigit(),
            style: const TextStyle(color: AppColors.appWhite, fontSize: 14)),
      ],
    ),
  );

  Widget _buildCardBalance() => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(71),
      gradient: LinearGradient(colors: [
        const Color.fromRGBO(250, 250, 250, 0.03).withAlpha(0),
        const Color.fromRGBO(250, 250, 250, 0.15).withAlpha(50),
      ]),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      children: [
        const Icon(Icons.remove_red_eye_outlined,
            color: AppColors.appWhite, size: 20),
        AppSpace.widthSpace_12,
        Text('1152230450'.seRagham().toPersianDigit(),
            style: const TextStyle(
                color: AppColors.appWhite,
                fontSize: 18,
                fontWeight: FontWeight.w600)),
        AppSpace.widthSpace_5,
        const Text('ریال',
            style: TextStyle(
                color: AppColors.appWhite,
                fontSize: 18,
                fontWeight: FontWeight.w600)),
      ],
    ),
  );
}
