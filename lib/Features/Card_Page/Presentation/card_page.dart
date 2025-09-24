import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/custom_card.dart';

import '../../../Core/Const/stack_circle.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
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
              image: AssetImage("assets/Image/Bank_Card/bank_mehr.jpg"),
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
              width: double.infinity,
              height: 300,
              color: Theme.of(context).primaryColor,
              child: Stack(
                children: [
                  StackCircle(
                      topPosition: -50,
                      rightPosition: -150,
                      height: 300,
                      width: 300
                  ),
                  StackCircle(
                      topPosition: -50,
                      leftPosition: -100,
                      height: 250,
                      width: 250
                  ),
                  StackCircle(
                      topPosition: 150,
                      leftPosition: 120,
                      width: 100,
                      height: 100),
                  StackCircle(
                    leftPosition: 220,
                    topPosition: 250,
                    width: 50,
                    height: 50,
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 12),
                      const Text(
                        'کارت‌های من',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      const SizedBox(height: 32),
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
                ],
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
