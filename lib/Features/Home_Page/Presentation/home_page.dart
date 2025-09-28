import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Core/Const/stack_circle.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/custom_card.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../Core/Utils/neo_bank_logo.dart';
import '../../../Core/Utils/neo_bank_version.dart';
import '../../Menu_Page/Presentation/Component/inward_curve_clipper.dart';
import '../../Menu_Page/Presentation/Component/slider_image.dart';
import 'Component/custom_icon.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    {
      'card_number': '6063732514168589',
      'card_expire_date': '08/06',
    },
    {
      'card_number': '5022291075418596',
      'card_expire_date': '11/27',
    }
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

    // ساخت لیست کارت‌ها + کارت اضافه کردن
    final List<Widget> cardItems = [
      ...sampleCard.map((card) {
        return Container(
          width: double.infinity,
          height: 192,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: AppColors.appWhite
            ),
            borderRadius: BorderRadius.circular(20),
            color: AppColors.splashGradiantColor2
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 20
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 94,
                            height: 24,
                            child: SvgPicture.asset(
                              'assets/svg/Union.svg',
                              colorFilter: ColorFilter.mode(
                                AppColors.appWhite,
                                BlendMode.srcIn,
                              ),
                            )
                        ),
                        Spacer(),
                        SizedBox(
                          width: 27,
                          height: 25,
                          child: Image.asset(
                            'assets/logo/Logomark.png',
                            color: AppColors.appWhite,
                          ),
                        ),

                      ],
                    ),
                  )
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                    left: 40,
                    right: 40
                  ),
                  child: Row(
                    children: [
                      Text(
                        (card['card_number'] ?? '').replaceAllMapped(
                          RegExp(r".{1,4}"), // هر ۴ رقم
                              (match) => "${match.group(0)} ".toPersianDigit(), // اضافه کردن فاصله بعد از هر گروه
                        ),
                        style: const TextStyle(
                          color: AppColors.appWhite,
                          fontSize: 14,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '${card['card_expire_date']}'.toPersianDigit(),
                        style: const TextStyle(
                          color: AppColors.appWhite,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpace.heightSpace_12,
                Padding(
                  padding: EdgeInsets.only(
                    right: 20,
                    left: 20
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(71),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(250, 250, 250, 0.03).withAlpha(0),
                          Color.fromRGBO(250, 250, 250, 0.15).withAlpha(50),
                        ]
                      )
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          Icon(Icons.remove_red_eye_outlined,
                            color: AppColors.appWhite,
                            size: 20,
                          ),
                          AppSpace.widthSpace_12,
                          Text('1152230450'.seRagham().toPersianDigit(),
                            style: const TextStyle(
                              color: AppColors.appWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.w600
                            ),),
                          AppSpace.widthSpace_5,
                          Text('ریال',
                            style: const TextStyle(
                              color: AppColors.appWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        );
      }),
      // کارت افزودن
      InkWell(
        onTap: () {
          debugPrint("Add Card Clicked   ");
          context.push('/add_card_page');
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade400, width: 2),
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              size: 80,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    ];

    final List<Widget> cardItems2 = [
      ...sampleCard2.map((card) {
        return Container(
          width: double.infinity,
          height: 192,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 2,
                  color: AppColors.appWhite
              ),
              borderRadius: BorderRadius.circular(20),
              color: AppColors.splashGradiantColor1
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 20
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('تسهیلات فوری تا سقف',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.appWhite,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Text('۱۰۰,۰۰۰,۰۰۰ تومان',
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors.appWhite,
                          fontWeight: FontWeight.w700
                      ),),
                  ],
                ),
                Image.asset('assets/image/banking-finance-bank-money.png',
                  width: 78,
                  height: 54,
                )
              ],
            )
          ),
        );
      }),
      // کارت افزودن
      InkWell(
        onTap: () {
          debugPrint("Add Card Clicked   ");
          context.push('/add_card_page');
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade400, width: 2),
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              size: 80,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    ];

    bool isSwitched = false;

    void toggleSwitch(bool value) {
      setState(() {
        isSwitched = value;
      });
    }

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 90,
              width: double.infinity,
              color: AppColors.appWhite,
              child: Padding(
                padding: EdgeInsets.only(
                  right: 20,
                  left: 20,
                  bottom: 20
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      NeoBankLogo(
                        logoColor: AppColors.splashGradiantColor1,
                        width: 88,
                        height: 24,
                        logoHeight: 20,
                        logoWidth: 62,
                        space: 4,
                      ),
                      Spacer(),
                      SvgPicture.asset('assets/svg/search-md.svg')
                    ],
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.splashGradiantColor2,
                              AppColors.splashGradiantColor2,
                              AppColors.splashGradiantColor2,
                              AppColors.splashGradiantColor2,
                              AppColors.splashGradiantColor2,
                              Color(0xff058eb5),
                              AppColors.splashGradiantColor2,
                              AppColors.splashGradiantColor2,
                              AppColors.splashGradiantColor2,
                            ]
                        ),
                      ),
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 30
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CarouselSlider(
                        items: cardItems,
                        carouselController: _controller,
                        options: CarouselOptions(
                          autoPlay: false,
                          enlargeCenterPage: true,
                          aspectRatio: 2.0,
                          viewportFraction: 0.8,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          },
                        ),
                      ),

                      // دایره های indicator
                      Padding(
                        padding: EdgeInsets.only(
                          left: 30,
                          top: 25
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: cardItems.asMap().entries.map((entry) {
                            int index = entry.key;
                            return _current != index ? Container(
                              width: 8.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == index
                                    ? AppColors.appWhite  // دایره فعال
                                    : AppColors.splashGradiantColor1 ,       // دایره غیر فعال
                              ),
                            )
                                : Container(
                              width: 42.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: _current == index
                                    ? AppColors.appWhite  // دایره فعال
                                    : AppColors.splashGradiantColor1 ,       // دایره غیر فعال
                              ),
                            ) ;
                          }).toList(),
                        ),
                      ),
                    ],
                  )
                  ,
                )
              ],
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index){
                  return Padding(
                    padding: EdgeInsets.only(
                      left: 24,
                      top: 20
                    ),
                    child: CustomIcon(
                      imagePath: 'assets/svg/simcard.svg',
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 120,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  right: 20,
                  left: 20
                ),
                child: Stack(
                  children: [
                    CarouselSlider(
                      items: cardItems2,
                      carouselController: _controller1,
                      options: CarouselOptions(
                        height: 120.0,
                        enlargeCenterPage: false,
                        autoPlay: false,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current1 = index;
                          });
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 30,
                            top: 25
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: cardItems2.asMap().entries.map((entry) {
                            int index = entry.key;
                            return Container(
                              width: 24.0,
                              height: 2.0,
                              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: _current1 == index
                                    ? AppColors.appWhite  // دایره فعال
                                    : AppColors.splashGradiantColor2 ,       // دایره غیر فعال
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  ],
                )
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  top: 20,
                  right: 10,
                  left: 10,
                ),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpace.heightSpace_16,
                    Text('تنظیمات',
                        style: Theme.of(context).textTheme.bodyLarge),
                    AppSpace.heightSpace_16,
                    Expanded(
                      child: ListView(
                        children: [
                          CustomCard(
                              iconData: Icons.block,
                              title: 'مسدود سازی',
                              widget1: Text('کارت عابر خود را به صورت موقت غیرفعال کنید.',
                                style: TextStyle(
                                    color: Colors.grey
                                ),
                              ),
                              widget2: Switch(
                                value: isSwitched,
                                onChanged: toggleSwitch,
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduces the tap target size
                              )
                          ),
                          AppSpace.heightSpace_16,
                          CustomCard(
                              iconData: Icons.security,
                              title: 'تنظیمات امنیتی',
                              widget1: Text('تغییر و دریافت رمز مجدد کارت',
                                style: TextStyle(
                                    color: Colors.grey
                                ),),
                              widget2: Icon(Icons.arrow_forward_ios)
                          ),
                          AppSpace.heightSpace_16,
                          CustomCard(
                              iconData: Icons.currency_exchange,
                              title: 'تعویض کارت',
                              widget1: Text('می توانید کارت جدید سفارش دهید',
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary
                                ),),
                              widget2: Icon(Icons.arrow_forward_ios)
                          ),
                          AppSpace.heightSpace_16,
                          CustomCard(
                            iconData: Icons.currency_exchange,
                            title: 'غیر فعال کردن',
                            widget1: Text('مسدودسازی کارت در صورت مفقودی و ...',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary
                              ),),
                            widget2: Icon(Icons.arrow_forward_ios),
                            circleColor: Colors.red.withAlpha(30),
                            textColor: Colors.red,
                          ),
                          AppSpace.heightSpace_90,
                        ],
                      ),
                    )

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}