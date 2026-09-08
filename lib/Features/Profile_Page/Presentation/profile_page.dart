import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Core/Services/Biometric_Service/biometric_service.dart';
import '../../../Core/Services/check_connection_service.dart';
import '../../../Core/Services/token_storage_service.dart';
import '../../../Core/Spacing/app_space.dart';
import '../../../Core/Theme/app_colors.dart';
import '../../../Core/Widgets/custom_divider.dart';
import '../../../Core/Widgets/custom_header.dart';
import '../../EKYC_Authentication_Page/Presentation/Bloc/Abort_Token_Bloc/abort_token_bloc.dart';
import '../../EKYC_Authentication_Page/Presentation/Bloc/Abort_Token_Bloc/abort_token_event.dart';
import 'Bloc/Citizen_EKYC_Status_Bloc/citizen_ekyc_status_bloc.dart';
import 'Bloc/Citizen_EKYC_Status_Bloc/citizen_ekyc_status_event.dart';
import 'Bloc/Profile_Bloc/profile_bloc.dart';
import 'Bloc/Profile_Bloc/profile_event.dart';
import 'Bloc/Profile_Bloc/profile_state.dart';
import 'Component/authentication_status_dialog.dart';
import 'Component/name_and_phone.dart';
import 'Component/profile_main_container.dart';
import 'Component/profile_page_custom_card.dart';
import 'Component/switch_theme.dart';
import 'Component/user_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final BiometricService _biometricService = BiometricService();
  bool isSupported = false;
  bool isSwitchOn = false;

  static const _prefKey = 'biometric_enabled';

  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context).add(GetProfileEventEvent());
    BlocProvider.of<CitizenEkycStatusBloc>(context).add(FetchCitizenEkycStatusEvent());
    checkConnection(context);
    _initState();
    super.initState();
  }

  Future<void> _initState() async {
    await _checkBiometricSupport();
    await _loadSwitchState();
  }

  Future<void> _checkBiometricSupport() async {
    final supported = await _biometricService.isSupported();
    setState(() {
      isSupported = supported;
    });
  }

  // بارگذاری وضعیت سوئیچ از SharedPreferences
  Future<void> _loadSwitchState() async {
    final prefs = await SharedPreferences.getInstance();
    final storedValue = prefs.getBool(_prefKey) ?? false;
    setState(() {
      isSwitchOn = storedValue;
    });
  }

  // ذخیره وضعیت سوئیچ در SharedPreferences
  Future<void> _saveSwitchState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKey, value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryFixed,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              /// --- Header ---
              navHeader(
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
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {

                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const UserImage(),
                            AppSpace.widthSpace_12,
                            NameAndPhone(
                              userName: state.userName!,
                              mobileNumber: state.mobileNumber!,
                            ),
                          ],
                        ),
                        AppSpace.heightSpace_24,

                        /// --- Account Section ---
                        profileMainContainer(
                          context,
                          children: [

                            /// نام کاربری
                            ProfilePageCustomCard(
                              iconPath: 'assets/svg/user-03.svg',
                              title: 'نام کاربری',
                              value: state.userName!,
                              widget: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 20,
                                color: AppColors.loginPageIconColor,
                              ),
                            ),
                            divider(),

                            /// وضعیت احراز هویت
                            InkWell(
                              onTap: (){
                                context.read<CitizenEkycStatusBloc>()
                                    .add(FetchCitizenEkycStatusEvent());
                                authenticationStatusDialog(context, theme);
                              },
                              child: ProfilePageCustomCard(
                                iconPath: 'assets/svg/authentication.svg',
                                title: 'وضعیت احراز هویت',
                                widget: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 20,
                                  color: AppColors.loginPageIconColor,
                                ),
                              ),
                            ),
                            divider(),

                            /// وضعیت احراز هویت
                            InkWell(
                              onTap: (){
                                context.read<AbortTokenBloc>()
                                    .add(GetAbortTokenEvent());
                              },
                              child: ProfilePageCustomCard(
                                iconPath: 'assets/svg/authentication.svg',
                                title: 'امحاء توکن',
                                widget: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 20,
                                  color: AppColors.loginPageIconColor,
                                ),
                              ),
                            ),
                            divider(),

                            /// رمز همراه بانک
                            InkWell(
                              onTap: (){
                                context.push('/set_pass_page', extra: true);
                              },
                              child: ProfilePageCustomCard(
                                iconPath:
                                'assets/svg/bank_services_page/passcode.svg',
                                title: 'رمز همراه بانک',
                                widget: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 20,
                                  color: AppColors.loginPageIconColor,
                                ),
                              ),
                            ),
                            divider(),

                            /// ورود بیومتریک
                            ProfilePageCustomCard(
                                iconPath: 'assets/svg/fingerprint-03.svg',
                                title: 'ورود بیومتریک',
                                widget: SizedBox(
                                  height: 24,
                                  width: 40,
                                  child: Transform.scale(
                                    scale: 0.7,
                                    child: Switch(
                                      activeTrackColor: AppColors.splashGradiantColor1,
                                      value: isSwitchOn,
                                      onChanged: isSupported
                                          ? (val) async {
                                        if (val == true) {
                                          // تلاش برای احراز هویت
                                          final success = await _biometricService.authenticate(false);

                                          if (!mounted) return;

                                          if (success) {
                                            setState(() {
                                              isSwitchOn = true;
                                            });
                                            await _saveSwitchState(true);
                                          } else {
                                            // اگر احراز هویت ناموفق بود
                                            setState(() {
                                              isSwitchOn = false;
                                            });

                                            if (!context.mounted) return;

                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('احراز هویت بیومتریک ناموفق بود'),
                                              ),
                                            );
                                          }
                                        } else {
                                          // خاموش کردن بدون احراز هویت
                                          setState(() {
                                            isSwitchOn = false;
                                          });
                                          await _saveSwitchState(false);
                                        }
                                      }
                                          : null,
                                    ),
                                  ),
                                )
                            ),
                          ],
                        ),

                        AppSpace.heightSpace_24,

                        /// --- Settings Section ---
                        profileMainContainer(
                          context,
                          children: [

                            /// تنظیمات
                            ProfilePageCustomCard(
                              iconPath: 'assets/svg/settings-02.svg',
                              title: 'تنظیمات',
                              widget: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 20,
                                color: AppColors.loginPageIconColor,
                              ),
                            ),
                            divider(),

                            /// درباره برنامه
                            InkWell(
                              onTap: (){
                                context.push('/about_application_page');
                              },
                              child: ProfilePageCustomCard(
                                iconPath: 'assets/svg/arrow-up.svg',
                                title: 'درباره برنامه',
                                widget: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 20,
                                  color: AppColors.loginPageIconColor,
                                ),
                              ),
                            ),
                            divider(),

                            /// درباره برنامه
                            ProfilePageCustomCard(
                              iconPath: 'assets/svg/info-circle.svg',
                              title: 'راهنما',
                              widget: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 20,
                                color: AppColors.loginPageIconColor,
                              ),
                            ),
                            divider(),

                            /// درباره برنامه
                            ProfilePageCustomCard(
                              iconPath: 'assets/svg/theme.svg',
                              title: 'زمینه',
                              widget: buildThemeSwitch(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),

              /// --- Logout Button ---
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Handle logout action
                    LocalStorageService.clear();
                    context.go('/');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.surfaceContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: Color(0xFFFDA29B),
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
                          Color(0xFFFDA29B),
                          BlendMode.srcIn,
                        ),
                      ),
                      AppSpace.widthSpace_8,
                      Text(
                        "خروج از حساب",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFFDA29B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              AppSpace.heightSpace_90,
            ],
          ),
        ),
      ),
    );
  }

}
