import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Features/Login_Page/Presentation/Component/login_header.dart';

import '../../../../Core/Const/app_colors.dart';
import '../../../../Core/Const/stack_circle.dart';
import '../../../../Core/Utils/custom_card.dart';
import 'custom_card.dart';

class CantLogin extends StatelessWidget {
  const CantLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.loginPageGradiantColor1, // #E6E6FA
                  AppColors.loginPageGradiantColor2, // #B0E0E6
                ]
            )
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: 20,
              right: 20
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpace.heightSpace_32,
              LoginHeader(
                  title: 'نمی توانید وارد شوید؟',
                  iconData: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: (){
                      context.pop();
                    },
                  )

              ),
              AppSpace.heightSpace_32,
              InkWell(
                  onTap: () {
                    context.push('/forget_username');
                  },
                  child: CustomCardWithBorder(
                    title: 'فراموشی نام کاربری',)
              ),
              AppSpace.heightSpace_16,
              CustomCardWithBorder(title: 'فراموشی رمز عبور',),
              AppSpace.heightSpace_16,
              CustomCardWithBorder(title: 'تغییر شماره تلفن همراه',),
            ],
          ),
        ),
      ),
    );
  }
}
