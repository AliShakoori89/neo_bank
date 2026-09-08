import 'package:flutter/material.dart';

import '../../../../Core/Theme/app_colors.dart';

class CustomCardWithBorder extends StatelessWidget {
  const CustomCardWithBorder({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [AppColors.splashGradiantColor1, AppColors.splashGradiantColor2],
          ),
          borderRadius: BorderRadius.circular(15)
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(
              right: 10,
              left: 10
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppColors.appWhite
                ),
              ),
              Icon(Icons.arrow_forward,
                color: AppColors.appWhite
              )
            ],
          ),
        ),
      ),
    );
  }
}
