import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Const/app_colors.dart';
import '../../../../Core/Const/app_space.dart';

class AdvertisementSliderImage extends StatelessWidget {
  const AdvertisementSliderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return VerticalSliderDemo();
  }
}

class VerticalSliderDemo extends StatefulWidget {
  const VerticalSliderDemo({super.key});


  @override
  State<VerticalSliderDemo> createState() => _VerticalSliderDemoState();
}

class _VerticalSliderDemoState extends State<VerticalSliderDemo> {
  int _current = 0;

  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context);

    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Column(
          children: [
            SizedBox(
                height: 150,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 10,
                      right: 10
                  ),
                  child: CarouselSlider(
                    items: [1, 2, 3, 4].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.grey.withAlpha(30),),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        AppSpace.heightSpace_32,
                                        Text(
                                            'با خدمات مالی و بانکی اپلیکیشن کیوبانک آشنا بشین',
                                            style: TextStyle(
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontSize: 12
                                            )
                                        ),
                                        AppSpace.heightSpace_4,
                                        Text(
                                            'هر لحظه و هر کجا که باشین، به تمام خدمات بانکی در اپلیکیشن کیوبانک دسترسی خواهید داشت. استف و کلیه خدمات سپرده و کارت در کنار امکانات دیگر ...',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontSize: 10
                                            ))
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                'assets/Image/slider_image.png',)
                                          )
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                    carouselController: _controller,
                    options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: true,
                        aspectRatio: 2.0,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                )
            ),
            AppSpace.heightSpace_16,
            Container(
              height: 24,
              width: 64,
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [1, 2, 3, 4]
                      .asMap()
                      .entries
                      .map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor
                                .withAlpha(
                                _current == entry.key ? 200 : 70)),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ]),
    );
  }
}