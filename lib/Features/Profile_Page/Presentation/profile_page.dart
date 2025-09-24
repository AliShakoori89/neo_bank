import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Component/custom_profile_card.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../Core/Const/stack_circle.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 230,
                  width: double.infinity,
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 15,
                      top: 20,
                      left: 15
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.qr_code_scanner,
                              color: Colors.black,
                            ),
                            Text('پروفایل',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14
                            ),),
                            Row(
                              children: [
                                Icon(Icons.share,
                                  color: Colors.black,),
                                AppSpace.widthSpace_12,
                                Icon(Icons.help,
                                  color: Colors.black,),
                              ],
                            )
                          ],
                        ),
                        AppSpace.heightSpace_42,
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/Image/user.png'),
                              fit: BoxFit.fill
                            )
                          ),
                        ),
                        AppSpace.heightSpace_12,
                        Text('علی شکوری',
                        style: TextStyle(
                          color: Colors.black,
                        ),),
                        AppSpace.heightSpace_12,
                        Text('09381083275'.toPersianDigit(),
                          style: TextStyle(
                            color: Colors.black,
                          ),),
                      ],
                    ),
                  ),
                ),
                StackCircle(
                    topPosition: -50,
                    rightPosition: -150,
                    height: 300,
                    width: 300
                ),
                StackCircle(
                    topPosition: -50,
                    leftPosition: -50,
                    height: 100,
                    width: 100
                ),
                StackCircle(
                    topPosition: 100,
                    leftPosition: -50,
                    height: 200,
                    width: 200
                ),
              ],
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10
                  ),
                  child: ListView(
                    children: [
                      CustomProfileCard(
                          iconData: Icons.person,
                          title: 'حساب کاربری',
                          subTitle: 'اطلاعات بانکی و شخصی'),
                      AppSpace.heightSpace_8,
                      CustomProfileCard(
                          iconData: Icons.security,
                          title: 'امنیت و حریم خصوصی',
                          subTitle: 'رمز عبور و تراکنش، اثر انگشت و ...'),
                      AppSpace.heightSpace_8,
                      CustomProfileCard(
                          iconData: Icons.notifications_none,
                          title: 'امنیت و حریم خصوصی',
                          subTitle: 'رمز عبور و تراکنش، اثر انگشت و ...'),
                      AppSpace.heightSpace_8,
                      CustomProfileCard(
                          iconData: Icons.theater_comedy_outlined,
                          title: 'نمایش',
                          subTitle: 'حالت روز و شب'),
                      AppSpace.heightSpace_8,
                      CustomProfileCard(
                          iconData: Icons.browser_updated,
                          title: 'بروز رسانی',
                          subTitle: 'بررسی نسخه برنامه'),
                      AppSpace.heightSpace_16,
                      Text('عمومی',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      AppSpace.heightSpace_16,
                      CustomProfileCard(
                          iconData: Icons.question_mark,
                          title: 'پشتیبانی',
                          subTitle: 'گفتگو، تماس و سوالات متداول'),
                      AppSpace.heightSpace_8,
                      CustomProfileCard(
                          iconData: Icons.insert_invitation,
                          title: 'دعوت از دوستان',
                          subTitle: 'هدیه نقدی برای شما'),
                      AppSpace.heightSpace_8,
                      CustomProfileCard(
                          iconData: Icons.comment_bank_outlined,
                          title: 'ثبت ایده ها و نظرات',
                          subTitle: 'رشد و بهبود کیو بانک در کنار شما'),
                      AppSpace.heightSpace_8,
                      CustomProfileCard(
                          iconData: Icons.browser_updated,
                          title: 'کیوبانک',
                          subTitle: 'قوانین و شرایط، درباره ما'),
                      AppSpace.heightSpace_64,
                      Center(
                        child: Text('Version 3.5.1',
                          style: Theme.of(context).textTheme.bodyMedium,),
                      ),
                      AppSpace.heightSpace_12,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/Logo/instagram.png',
                            fit: BoxFit.fill,
                            width: 20,
                            height: 20,
                          ),
                          AppSpace.widthSpace_8,
                          Image.asset('assets/Logo/twitter-alt.png',
                            fit: BoxFit.fill,
                            width: 20,
                            height: 20,),
                          AppSpace.widthSpace_8,
                          Image.asset('assets/Logo/telegram.png',
                            fit: BoxFit.fill,
                            width: 20,
                            height: 20,),
                          AppSpace.widthSpace_8,
                          Image.asset('assets/Logo/linkedin.png',
                            fit: BoxFit.fill,
                            width: 20,
                            height: 20,),
                        ],
                      ),
                      AppSpace.heightSpace_200,
                    ]
                  )
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
