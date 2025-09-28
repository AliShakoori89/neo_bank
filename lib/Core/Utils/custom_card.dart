import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../Const/app_colors.dart';
import '../Const/app_space.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.deposit, required this.title, required this.subtitle, this.circleColor, this.textColor, required this.mount, required this.date});

  final bool deposit;
  final String title;
  final String subtitle;
  final String mount;
  final String date;

  final Color? circleColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                        color: deposit ? AppColors.homePageIconColor : AppColors.homePageDividerColor,
                        shape: BoxShape.circle
                    ),
                    child: Center(
                      child: Icon(deposit ? Icons.arrow_downward : Icons.arrow_upward,
                        size: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.homePageCardTitleColor,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          AppSpace.heightSpace_4,
                          Text(
                            'خلق ثروت سرزمین پارسه',
                            style: TextStyle(color: AppColors.loginPageTextColor),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(mount,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.green.shade800,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          AppSpace.heightSpace_4,
                          Text(
                            date,
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(Icons.arrow_forward_ios,
                    size: 20,
                    color: AppColors.loginPageIconColor,
                  ),
                )
              ],
            ),
            AppSpace.heightSpace_8,
            Padding(
              padding: EdgeInsets.only(
                right: 10,
                left: 10
              ),
              child: Divider(
                height: 1,
                color: AppColors.homePageDividerColor,
              ),
            )
          ],
        ),
      ),
    );;
  }
}
