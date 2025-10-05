import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../Core/Const/app_colors.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Theme.of(context).navigationBarTheme.backgroundColor!, // پس‌زمینه نوار پایین
      ),
      child: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,

        onTap: widget.onTap,
        items: [
          widget.currentIndex == 0
              ? BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).navigationBarTheme.indicatorColor
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(
                  'assets/icon/navigation_bar_icon/home-line.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    widget.currentIndex == 0
                        ? AppColors.splashGradiantColor2 // رنگ انتخاب‌شده
                        : AppColors.loginPageIconColor, // رنگ انتخاب‌نشده
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            label: '',
          )
              : BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icon/navigation_bar_icon/home-line.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                widget.currentIndex == 0
                    ? AppColors.splashGradiantColor2 // رنگ انتخاب‌شده
                    : AppColors.loginPageIconColor, // رنگ انتخاب‌نشده
                BlendMode.srcIn,
              ),
            ),
            label: '',
          ),
          widget.currentIndex == 1 ? BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).navigationBarTheme.indicatorColor
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(
                  'assets/icon/navigation_bar_icon/switch-vertical-02.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    widget.currentIndex == 1
                        ? AppColors.splashGradiantColor2   // رنگ انتخاب‌شده
                        : AppColors.loginPageIconColor,   // رنگ انتخاب‌نشده
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            label: '',
          )
              : BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icon/navigation_bar_icon/switch-vertical-02.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                widget.currentIndex == 1
                    ? AppColors.splashGradiantColor2   // رنگ انتخاب‌شده
                    : AppColors.loginPageIconColor,   // رنگ انتخاب‌نشده
                BlendMode.srcIn,
              ),
            ),
            label: '',
          ),
          widget.currentIndex == 2
              ? BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).navigationBarTheme.indicatorColor
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(
                  'assets/icon/navigation_bar_icon/grid-01.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    widget.currentIndex == 2
                        ? AppColors.splashGradiantColor2   // رنگ انتخاب‌شده
                        : AppColors.loginPageIconColor,   // رنگ انتخاب‌نشده
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            label: '',
          )
              : BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icon/navigation_bar_icon/grid-01.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                widget.currentIndex == 2
                    ? AppColors.splashGradiantColor2   // رنگ انتخاب‌شده
                    : AppColors.loginPageIconColor,   // رنگ انتخاب‌نشده
                BlendMode.srcIn,
              ),
            ),
            label: '',
          ),
          widget.currentIndex == 3
              ? BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).navigationBarTheme.indicatorColor
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(
                  'assets/icon/navigation_bar_icon/bar-chart-07.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    widget.currentIndex == 3
                        ? AppColors.splashGradiantColor2   // رنگ انتخاب‌شده
                        : AppColors.loginPageIconColor,   // رنگ انتخاب‌نشده
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            label: '',
          )
              : BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icon/navigation_bar_icon/bar-chart-07.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                widget.currentIndex == 3
                    ? AppColors.splashGradiantColor2   // رنگ انتخاب‌شده
                    : AppColors.loginPageIconColor,   // رنگ انتخاب‌نشده
                BlendMode.srcIn,
              ),
            ),
            label: '',
          ),
          widget.currentIndex == 4
              ? BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).navigationBarTheme.indicatorColor
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Image.asset('assets/icon/navigation_bar_icon/Avatar.png'),
              ),
            ),
            label: '',
          )
              : BottomNavigationBarItem(
            icon: Image.asset('assets/icon/navigation_bar_icon/Avatar.png'),
            label: '',
          ),
        ],
      ),
    )
    ;
  }
}
