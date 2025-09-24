import 'package:flutter/material.dart';
import '../../../../Core/Const/app_space.dart';

class CustomProfileCard extends StatelessWidget {
  const CustomProfileCard({super.key, required this.iconData, required this.title, required this.subTitle});

  final IconData iconData;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withAlpha(30),
          borderRadius: BorderRadius.circular(15)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle
                  ),
                  child: Icon(iconData,
                    color: Colors.black,
                  ),
                ),
                AppSpace.widthSpace_12,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    AppSpace.heightSpace_8,
                    Text(subTitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                )
              ],
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
