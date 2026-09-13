import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Core/Spacing/app_space.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/component/Gift_Tab_Body/Component/design_card.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/custom_header.dart';

import '../../../../../Core/Theme/app_colors.dart';

class SelectDesignPage extends StatelessWidget {
  const SelectDesignPage({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomHeader(title: 'انتخاب طرح', hasBackArrow: true),
              AppSpace.heightSpace_32,
              DesignCard(phoneNumber: phoneNumber, cardTitle: 'تولد', imgPath: 'assets/image/card_design/birthday.png', cardColor: AppColors.buttonIconColor,),
              AppSpace.heightSpace_24,
              DesignCard(phoneNumber: phoneNumber, cardTitle: 'روز مادر', imgPath: 'assets/image/card_design/mather_day.png', cardColor: AppColors.lowRedColor,),
              AppSpace.heightSpace_24,
              DesignCard(phoneNumber: phoneNumber, cardTitle: 'روز پدر', imgPath: 'assets/image/card_design/father_day.png', cardColor: AppColors.homePageTitleColor),
              AppSpace.heightSpace_24,
              DesignCard(phoneNumber: phoneNumber, cardTitle: 'تولد فرزند', imgPath: 'assets/image/card_design/child_birthday.png', cardColor: AppColors.navBarIconShadowColor),
              AppSpace.heightSpace_24,
              DesignCard(phoneNumber: phoneNumber, cardTitle: 'فارق التحصیل', imgPath: 'assets/image/card_design/alumnus.png', cardColor: AppColors.orangColor),
              AppSpace.heightSpace_24,
              DesignCard(phoneNumber: phoneNumber, cardTitle: 'مذهبی', imgPath: 'assets/image/card_design/religious_occasion.png', cardColor: AppColors.circleBorderColor),
              AppSpace.heightSpace_24,
            ]
          ),
        ),
      ),
    );
  }
}
