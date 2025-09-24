import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../Const/app_space.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.iconData, required this.title, required this.widget1, required this.widget2, this.circleColor, this.textColor});

  final IconData iconData;
  final String title;
  final Widget widget1;
  final Widget widget2;

  final Color? circleColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withAlpha(30),
          borderRadius: BorderRadius.circular(15)
      ),
      height: 70,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: circleColor ?? Colors.grey.withAlpha(100),
                      shape: BoxShape.circle
                  ),
                  child: Center(
                    child: Icon(iconData),
                  ),
                ),
                AppSpace.widthSpace_12,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                      style: TextStyle(
                          color: textColor ?? Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    AppSpace.heightSpace_4,
                    widget1
                  ],
                )
              ],
            ),
            widget2
          ],
        ),
      ),
    );;
  }
}
