import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/custom_header.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Bloc/Change_Theme_Bloc/change_theme_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Component/name_and_phone.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Component/profile_page_custom_card.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Component/user_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isBiometricEnabled = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimaryFixed,
        body: SingleChildScrollView(
          child: Column(
            children: [
              /// --- Header ---
              customHeader(
                context,
                Text(
                  'پروفایل کاربری',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.appBarTheme.titleTextStyle?.color,
                  ),
                ),
              ),

              /// --- User Info ---
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const UserImage(),
                        AppSpace.widthSpace_12,
                        const NameAndPhone(),
                      ],
                    ),
                    AppSpace.heightSpace_24,

                    /// --- Account Section ---
                    _buildProfileCard(
                      context,
                      children: [
                        ProfilePageCustomRow(
                          iconPath: 'assets/svg/user-03.svg',
                          title: 'نام کاربری',
                          value: 'mehrdadasd',
                          widget: const Icon(Icons.arrow_forward_ios_outlined, size: 20, color: AppColors.loginPageIconColor),
                        ),
                        _divider(),
                        ProfilePageCustomRow(
                          iconPath: 'assets/svg/bank_services_page/passcode.svg',
                          title: 'رمز همراه بانک',
                          widget: const Icon(Icons.arrow_forward_ios_outlined, size: 20, color: AppColors.loginPageIconColor),
                        ),
                        _divider(),
                        ProfilePageCustomRow(
                          iconPath: 'assets/svg/fingerprint-03.svg',
                          title: 'ورود بیومتریک',
                          widget: _buildBiometricSwitch(),
                        ),
                      ],
                    ),

                    AppSpace.heightSpace_24,

                    /// --- Settings Section ---
                    _buildProfileCard(
                      context,
                      children: [
                        ProfilePageCustomRow(
                          iconPath: 'assets/svg/settings-02.svg',
                          title: 'تنظیمات',
                          widget: const Icon(Icons.arrow_forward_ios_outlined, size: 20, color: AppColors.loginPageIconColor),
                        ),
                        _divider(),
                        ProfilePageCustomRow(
                          iconPath: 'assets/svg/arrow-up.svg',
                          title: 'درباره برنامه',
                          widget: const Icon(Icons.arrow_forward_ios_outlined, size: 20, color: AppColors.loginPageIconColor),
                        ),
                        _divider(),
                        ProfilePageCustomRow(
                          iconPath: 'assets/svg/info-circle.svg',
                          title: 'راهنما',
                          widget: const Icon(Icons.arrow_forward_ios_outlined, size: 20, color: AppColors.loginPageIconColor),
                        ),
                        _divider(),
                        InkWell(
                          onTap: () => _showThemeDialog(context),
                          child: ProfilePageCustomRow(
                            iconPath: 'assets/svg/theme.svg',
                            title: 'زمینه',
                            widget: _buildThemeSwitch(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// --- Logout Button ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Handle logout action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.surfaceContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: theme.buttonTheme.colorScheme!.secondary,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/log-out-02.svg',
                        width: 18,
                        height: 18,
                        colorFilter: ColorFilter.mode(
                          theme.buttonTheme.colorScheme!.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      AppSpace.widthSpace_8,
                      Text(
                        "خروج از حساب",
                        style: TextStyle(
                          fontSize: 14,
                          color: theme.buttonTheme.colorScheme!.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              AppSpace.heightSpace_90
            ],
          ),
        ),
      ),
    );
  }

  /// --- Helper Widgets ---
  Widget _buildProfileCard(BuildContext context, {required List<Widget> children}) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.surfaceContainer,
      ),
      child: Column(children: children),
    );
  }

  Widget _divider() => const Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Divider(height: 1, color: AppColors.homePageDividerColor),
  );

  Widget _buildBiometricSwitch() => Transform.scale(
    scale: 0.8,
    child: RotatedBox(
      quarterTurns: 90,
      child: Switch(
        value: isBiometricEnabled,
        activeColor: Colors.white,
        activeTrackColor: AppColors.splashGradiantColor1,
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: Colors.grey,
        onChanged: (value) => setState(() => isBiometricEnabled = value),
      ),
    ),
  );

  Widget _buildThemeSwitch(BuildContext context) => Row(
    children: [
      const Icon(Icons.light_mode, size: 20, color: AppColors.loginPageIconColor),
      SizedBox(
        height: 24,
        width: 40,
        child: Transform.scale(
          scale: 0.7,
          child: Switch(
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: (_) => context.read<ThemeBloc>().add(ThemeEvent.toggle),
          ),
        ),
      ),
      const Icon(Icons.dark_mode, size: 20, color: AppColors.loginPageIconColor),
    ],
  );

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
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
      ),
    );
  }
}
