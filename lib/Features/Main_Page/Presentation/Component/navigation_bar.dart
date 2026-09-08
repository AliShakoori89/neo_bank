import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../Core/Theme/app_colors.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Theme.of(
          context,
        ).navigationBarTheme.backgroundColor!, // پس‌زمینه نوار پایین
      ),
      child: Container(
        height: 85,
        decoration: BoxDecoration(
          color: Theme.of(context).navigationBarTheme.indicatorColor,
          border: Border(
            top: BorderSide(width: 1, color: AppColors.homePageDividerColor),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: widget.currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: widget.onTap,
          items: [
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 48,
                height: 48,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SvgPicture.asset(
                    'assets/icon/navigation_bar_icon/home-line.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      widget.currentIndex == 0
                          ? AppColors
                                .splashGradiantColor2 // رنگ انتخاب‌شده
                          : AppColors.loginPageIconColor, // رنگ انتخاب‌نشده
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 48,
                height: 48,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SvgPicture.asset(
                    'assets/icon/navigation_bar_icon/switch-vertical-02.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      widget.currentIndex == 1
                          ? AppColors
                                .splashGradiantColor2 // رنگ انتخاب‌شده
                          : AppColors.loginPageIconColor, // رنگ انتخاب‌نشده
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 48,
                height: 48,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SvgPicture.asset(
                    'assets/icon/navigation_bar_icon/grid-01.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      widget.currentIndex == 2
                          ? AppColors
                                .splashGradiantColor2 // رنگ انتخاب‌شده
                          : AppColors.loginPageIconColor, // رنگ انتخاب‌نشده
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 48,
                height: 48,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SvgPicture.asset(
                    'assets/icon/navigation_bar_icon/bar-chart-07.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      widget.currentIndex == 3
                          ? AppColors
                                .splashGradiantColor2 // رنگ انتخاب‌شده
                          : AppColors.loginPageIconColor, // رنگ انتخاب‌نشده
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 48,
                height: 48,
                child: Icon(
                  Icons.person_2_outlined,
                  color: widget.currentIndex == 4
                      ? AppColors
                            .splashGradiantColor2 // رنگ انتخاب‌شده
                      : AppColors.loginPageIconColor, // رنگ انتخاب‌نشده,),
                ),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
