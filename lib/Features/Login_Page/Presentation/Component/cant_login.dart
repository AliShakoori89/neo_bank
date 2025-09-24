import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Features/Login_Page/Presentation/Component/custom_header.dart';

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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            StackCircle(
                circleColor: Theme.of(context).primaryColor,
                topPosition: -40,
                width: 500,
                height: 500),
            StackCircle(
                circleColor: Theme.of(context).primaryColor,
                topPosition: 300,
                leftPosition: -30,
                width: 400,
                height: 400),
            StackCircle(
                circleColor: Theme.of(context).primaryColor,
                topPosition: 600,
                leftPosition: 200,
                width: 300,
                height: 300),
            Container(
              margin: EdgeInsets.only(
                right: 10,
                left: 10
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpace.heightSpace_32,
                  CustomHeader(
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
            )

          ],
        ),
      ),
    );
  }
}
