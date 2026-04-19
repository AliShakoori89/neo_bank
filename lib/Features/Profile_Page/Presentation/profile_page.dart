import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/custom_header.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Data_Sources/Local/token_storage.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Bloc/Profile_Bloc/profile_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Bloc/Profile_Bloc/profile_event.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Bloc/Profile_Bloc/profile_state.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Component/name_and_phone.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Component/profile_page_custom_card.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Component/user_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Core/Utils/App_Lock/Internet/internet_checker.dart';
import '../../Main_Page/main_page.dart';
import 'Component/Biometric_Service/biometric_service.dart';
import '../../../Core/Const/custom_divider.dart';
import 'Component/profile_main_container.dart';
import 'Component/switch_theme.dart';

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
    _checkConnection();
    _initState();
    super.initState();
  }

  Future<void> _initState() async {
    await _checkBiometricSupport();
    await _loadSwitchState();
  }

  void _refreshPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainPage(initialIndex: 4,)),
    );
  }

  Future<void> _checkConnection() async {
    await InternetChecker.checkInternet(
      context: context,
      onSuccess: _refreshPage,
    );
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
                                        final success = await _biometricService.authenticate();

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
                            ProfilePageCustomCard(
                              iconPath: 'assets/svg/arrow-up.svg',
                              title: 'درباره برنامه',
                              widget: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 20,
                                color: AppColors.loginPageIconColor,
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
                    LocalStorage.clearPrefsExcept(['isDarkTheme']);
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

  /// --- Helper Widgets ---
}
