import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../Core/Spacing/app_space.dart';
import '../../../../../../Core/Theme/app_colors.dart';

class DesignCard extends StatelessWidget {
  const DesignCard({super.key, required this.cardTitle, required this.imgPath, required this.cardColor, required this.phoneNumber});

  final String phoneNumber;
  final String cardTitle;
  final String imgPath;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      height: 200,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: (){
          context.push('message_and_amount_page', extra: {
            'phoneNumber': phoneNumber,
            'imgPath': imgPath,
            'cardTitle': cardTitle,
          });
        },
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 20
                ),
                child: Image.asset(
                  imgPath,
                  width: 180,
                  height: 180,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cardTitle,
                        style: TextStyle(
                          color: AppColors.appWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'انتخاب',
                            style: TextStyle(
                              color: AppColors.splashGradiantColor1,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          AppSpace.widthSpace_2,
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: AppColors.splashGradiantColor1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
