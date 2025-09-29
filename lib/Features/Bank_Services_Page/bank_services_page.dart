import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Core/Const/stack_circle.dart';

import '../../Core/Const/app_colors.dart';
import '../../Core/Const/app_space.dart';
import '../../Core/Utils/custom_header.dart';
import 'Presentation/Component/inward_curve_clipper.dart';
import 'Presentation/Component/slider_image.dart';

class BankServicesPage extends StatelessWidget {
  const BankServicesPage({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // --- Header ---

            customHeader(Text('انتقال وجه',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.customHeaderTextColor
              ),
            )),

            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: [

                  Text('واریز و پرداخت',
                    style: TextStyle(
                      color: AppColors.homePageTitleColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  Container(

                  )
                ],
              ),
            )


          ],
        )
      ),
    );
  }
}
