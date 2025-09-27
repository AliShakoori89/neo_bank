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
  int _current = 0;

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

  @override
  Widget build(BuildContext context) {
    // ساخت لیست کارت‌ها + کارت اضافه کردن
    final List<Widget> cardItems = [
      ...sampleCard.map((card) {
        return Container(
          width: double.infinity,
          height: 220,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: AssetImage("assets/image/Bank_Card/bank_mehr.jpg"),
                  fit: BoxFit.fill
              )
          ),
          child: Padding(
            padding: EdgeInsets.only(
                top: 100,
                left: 10,
                right: 10,
                bottom: 20
            ),
            child: Column(
              children: [
                Expanded(
                  child: Text(
                    card['card_number'] ?? '',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                AppSpace.heightSpace_32,
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'تاریخ انقضا: ${card['card_expire_date']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
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
                  left: 30,
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
            Container(
              width: double.infinity,
              height: 300,
              color: Colors.black,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomPaint(
                      painter: ShapePainter(),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.25,
                        height: 300,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.splashGradiantColor1,
                                AppColors.splashGradiantColor1,
                                AppColors.splashGradiantColor1,
                                Colors.black,
                              ]
                          ),
                        ),
                      ),
                    )
                  ),
                  Container(
                    decoration: BoxDecoration(
                      // color: AppColors.splashGradiantColor2,
                        image: DecorationImage(
                          image: AssetImage('assets/image/Ellipse 2.png'),
                          fit: BoxFit.fill
                        )
                    ),
                    child: Column(
                      children: [
                        AppSpace.heightSpace_24,
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
                      ],
                    ),
                  ),
                ],
              )
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
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(50),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.share),
                                AppSpace.heightSpace_12,
                                Text('شماره کارت و شبا',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              ],
                            ),
                          ),
                        ),
                        AppSpace.widthSpace_8,
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(50),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.key),
                                AppSpace.heightSpace_12,
                                Text('رمز دوم پویا',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
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


class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path()
      ..moveTo(0, 0) // نقطه شروع (بالا-چپ)
      ..lineTo(size.width, 0) // به بالا-راست
      ..lineTo(size.width, size.height * 0.5) // به وسط-راست
      ..lineTo(size.width * 0.5, size.height) // به پایین-وسط
      ..lineTo(0, size.height) // به پایین-چپ
      ..close(); // بستن شکل

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}