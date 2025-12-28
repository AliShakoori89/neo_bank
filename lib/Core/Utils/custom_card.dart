import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../Const/app_colors.dart';
import '../Const/app_space.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.deposit,
    required this.title,
    required this.subtitle,
    this.circleColor,
    this.textColor,
    required this.mount,
    required this.date,
  });

  final bool deposit;
  final String title;
  final String subtitle;
  final String mount;
  final String date;

  final Color? circleColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: width < 400 ? 100 : 70,
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
                      color: deposit
                          ? Theme.of(context).colorScheme.inverseSurface
                          : Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        deposit ? Icons.arrow_downward : Icons.arrow_upward,
                        size: 16,
                        color: deposit
                            ? Theme.of(context).colorScheme.onSecondary
                            : Theme.of(context).colorScheme.onInverseSurface,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            AppSpace.heightSpace_4,
                            Text(
                              'خلق ثروت سرزمین پارسه',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              mount.seRagham(),
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.onTertiary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            AppSpace.heightSpace_4,
                            Text(
                              date,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: AppColors.loginPageIconColor,
                  ),
                ),
              ],
            ),
            AppSpace.heightSpace_12,
            Padding(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: Divider(height: 1, color: Theme.of(context).dividerColor),
            ),
          ],
        ),
      ),
    );
  }
}
