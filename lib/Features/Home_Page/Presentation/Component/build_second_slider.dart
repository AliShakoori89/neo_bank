import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../Core/Theme/app_colors.dart';
import '../../../../Core/Theme/app_them.dart';
import '../../../Profile_Page/Presentation/Bloc/Change_Theme_Bloc/change_theme_bloc.dart';

/// 🔹 اسلایدر دوم
Widget buildSecondSlider(
  BuildContext context,
  CarouselSliderController controller,
  int currentIndex,
  List<Map<String, String>> sampleCard2,
  {required Function(int) onPageChanged}
) {
  final cardItems2 = sampleCard2
      .map(
        (card) => BlocBuilder<ThemeBloc, ThemeData>(
          builder: (context, theme) {
            return Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: theme == AppTheme.lightTheme ? 2 : 0,
                  color: AppColors.appWhite,
                ),
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  transform: GradientRotation(
                    45 * (3.1415926 / 180),
                  ), // تبدیل درجه به رادیان
                  colors: [
                    AppColors.homePageTitleColor,
                    AppColors.splashGradiantColor1,
                  ],
                  stops: [0.0, 1.0],
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        card['card_title'] ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.appWhite,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${card['card_value']}'.seRagham().toPersianDigit(),
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.appWhite,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Image.asset(card['card_image'] ?? '', width: 78, height: 54),
                ],
              ),
            );
          },
        ),
      )
      .toList();

  return Container(
    color: Theme.of(context).colorScheme.surfaceContainer,
    height: 140,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Stack(
        children: [
          CarouselSlider(
            items: cardItems2,
            carouselController: controller,
            options: CarouselOptions(height: 120, viewportFraction: 1, onPageChanged: (index, reason) {
              onPageChanged(index); // 👈 پدر را خبر کن
            },),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
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
                      color: currentIndex == index
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
