import 'package:flutter/material.dart';

import '../../../../Core/Theme/app_colors.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    super.key,
    required this.tabController,
    required this.label,
  });

  final TabController tabController;
  final List label;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 30, left: 30),
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.surfaceContainer,
        border: BoxBorder.all(color: Theme.of(context).colorScheme.surfaceDim),
      ),
      child: TabBar(
        controller: widget.tabController,
        // padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
        indicatorSize: TabBarIndicatorSize.label,

        indicatorPadding: const EdgeInsets.only(top: 5, bottom: 5),
        labelColor: Theme.of(context).colorScheme.primaryFixed,
        unselectedLabelColor: AppColors.loginPageHintFontColor,
        dividerColor: Colors.transparent,
        indicatorColor: Colors.white,
        overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
        indicator: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimaryFixed,
          borderRadius: BorderRadius.circular(8),
        ),
        tabs: List.generate(2, (index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Text(widget.label[index]),
          );
        }),
      ),
    );
  }
}
