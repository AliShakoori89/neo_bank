import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Component/name_and_phone.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Component/profile_page_custom_card.dart';
import '../../../Core/Const/app_colors.dart';
import '../../../Core/Utils/custom_header.dart';
import 'Bloc/Change_Theme_Bloc/change_theme_bloc.dart';
import 'Component/user_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // --- Header ---
              customHeader(context, Text(
                'پروفایل کاربری',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).appBarTheme.titleTextStyle!.color),
              )),
          
              // --- Body ---
              Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        UserImage(),
                        AppSpace.widthSpace_12,
                        NameAndPhone()
                      ],
                    ),
                    AppSpace.heightSpace_24,
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                          left: 16,
                          right: 16
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).colorScheme.surfaceContainer,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 8,
                          bottom: 8
                        ),
                        child: Column(
                          children: [
                            ProfilePageCustomRow(
                              iconPath: 'assets/svg/user-03.svg',
                              title: 'نام کاربری',
                              value: 'mehrdadasd',
                              widget: Icon(Icons.arrow_forward_ios_outlined,
                                size: 20,
                                color: AppColors.loginPageIconColor,
                              ),
                            ),
                            AppSpace.heightSpace_8,
                            Divider(
                              height: 1,
                              color: AppColors.homePageDividerColor,
                            ),
                            AppSpace.heightSpace_8,
                            ProfilePageCustomRow(
                              iconPath: 'assets/svg/bank_services_page/passcode.svg',
                              title: 'رمز همراه بانک',
                              value: '',
                              widget: Icon(Icons.arrow_forward_ios_outlined,
                                size: 20,
                                color: AppColors.loginPageIconColor,
                              ),
                            ),
                            AppSpace.heightSpace_8,
                            Divider(
                              height: 1,
                              color: AppColors.homePageDividerColor,
                            ),
                            AppSpace.heightSpace_8,
                            ProfilePageCustomRow(
                              iconPath: 'assets/svg/fingerprint-03.svg',
                              title: 'ورود بیومتریک',
                              value: '',
                              widget: SizedBox(

                                child: Transform.scale(
                                  scale: 0.8,
                                  child: RotatedBox(
                                    quarterTurns: 90,
                                    child: Switch(
                                      value: isSwitched,
                                      padding: EdgeInsets.all(
                                        2
                                      ),
                                      activeColor: Colors.white, // رنگ دایره وقتی روشن است
                                      activeTrackColor: AppColors.splashGradiantColor1, // رنگ پس‌زمینه وقتی روشن است
                                      inactiveThumbColor: Colors.white, // رنگ دایره وقتی خاموش است
                                      inactiveTrackColor: Colors.grey, // رنگ پس‌زمینه وقتی خاموش است
                                      onChanged: (value) {
                                        setState(() {
                                          isSwitched = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppSpace.heightSpace_24,
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                          left: 16,
                          right: 16
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).colorScheme.surfaceContainer,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 8,
                            bottom: 8
                        ),
                        child: Column(
                          children: [
                            ProfilePageCustomRow(
                              iconPath: 'assets/svg/settings-02.svg',
                              title: 'تنظیمات',
                              value: '',
                              widget: Icon(Icons.arrow_forward_ios_outlined,
                                size: 20,
                                color: AppColors.loginPageIconColor,
                              ),
                            ),
                            AppSpace.heightSpace_8,
                            Divider(
                              height: 1,
                              color: AppColors.homePageDividerColor,
                            ),
                            AppSpace.heightSpace_8,
                            ProfilePageCustomRow(
                              iconPath: 'assets/svg/arrow-up.svg',
                              title: 'درباره برنامه',
                              value: '',
                              widget: Icon(Icons.arrow_forward_ios_outlined,
                                size: 20,
                                color: AppColors.loginPageIconColor,
                              ),
                            ),
                            AppSpace.heightSpace_8,
                            Divider(
                              height: 1,
                              color: AppColors.homePageDividerColor,
                            ),
                            AppSpace.heightSpace_8,
                            ProfilePageCustomRow(
                              iconPath: 'assets/svg/info-circle.svg',
                              title: 'راهنما',
                              value: '',
                              widget: Icon(Icons.arrow_forward_ios_outlined,
                                size: 20,
                                color: AppColors.loginPageIconColor,
                              ),
                            ),
                            AppSpace.heightSpace_8,
                            Divider(
                              height: 1,
                              color: AppColors.homePageDividerColor,
                            ),
                            AppSpace.heightSpace_8,
                            // InkWell(
                            //   child: ProfilePageCustomRow(
                            //     iconPath: 'assets/svg/theme.svg',
                            //     title: 'زمینه',
                            //     value: '',
                            //     widget: Icon(Icons.arrow_forward_ios_outlined,
                            //       size: 20,
                            //       color: AppColors.loginPageIconColor,
                            //     ),
                            //   ),
                            //   onTap: (){
                            //     showAlertDialog(context);
                            //   },
                            // ),
                            InkWell(
                              child: ProfilePageCustomRow(
                                iconPath: 'assets/svg/theme.svg',
                                title: 'زمینه',
                                value: '',
                                widget: Row(
                                  children: [
                                    Icon(Icons.light_mode,
                                      size: 20,
                                      color: AppColors.loginPageIconColor,
                                    ),
                                    SizedBox(
                                      height: 24,
                                      width: 40,
                                      child: Transform.scale(
                                        scale: 0.7, // بین 0.5 تا 1.0 بسته به اندازه دلخواه
                                        child: Switch(
                                          value: Theme.of(context).brightness == Brightness.dark,
                                          activeColor: AppColors.splashGradiantColor1,
                                          onChanged: (_) {
                                            context.read<ThemeBloc>().add(ThemeEvent.toggle);
                                          },
                                        ),
                                      ),
                                    ),
                                    Icon(Icons.dark_mode,
                                      size: 20,
                                      color: AppColors.loginPageIconColor,
                                    ),

                                  ],
                                ),
                              ),
                              onTap: (){
                                // showAlertDialog(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(
                  left: 14,
                  right: 14,
                  top: 10,
                  bottom: 10
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // کاری که باید انجام بشه
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainer,   // رنگ پس‌زمینه
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // گوشه‌های گرد
                      side: BorderSide(
                        color: Theme.of(context).buttonTheme.colorScheme!.secondary,
                        width: 1
                      )
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/log-out-02.svg',
                        fit: BoxFit.fill,
                        width: 18,
                        height: 18,
                        colorFilter: ColorFilter.mode(Theme.of(context).buttonTheme.colorScheme!.primary, BlendMode.srcIn),
                      ),
                      AppSpace.widthSpace_8,
                      Text(
                        "خروج از حساب",
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).buttonTheme.colorScheme!.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              )          ],
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Switch(
            value: Theme.of(context).brightness == Brightness.dark,
            activeColor: AppColors.splashGradiantColor1,
            onChanged: (_) {
              context.read<ThemeBloc>().add(ThemeEvent.toggle);
              Navigator.pop(context);
            },
          ),
        ),
      );
    },
  );
}
