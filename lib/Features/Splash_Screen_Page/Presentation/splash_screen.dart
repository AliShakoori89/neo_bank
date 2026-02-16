import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/neo_bank_version.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/neo_bank_logo.dart';

import 'VPN_Bloc/vpn_bloc.dart';
import 'VPN_Bloc/vpn_event.dart';
import 'VPN_Bloc/vpn_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  late VpnBloc vpnBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    vpnBloc = context.read<VpnBloc>();

    // بررسی اولیه VPN بعد از render شدن صفحه
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vpnBloc.add(CheckVpnEvent());
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      vpnBloc.add(CheckVpnEvent());
    }
  }

  void _showVpnDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return BlocBuilder<VpnBloc, VpnState>(
          builder: (context, state) {
            // اگر VPN قطع شد، دیالوگ بسته بشه
            if (state is VpnDisconnected) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (Navigator.canPop(context)) Navigator.pop(context);
              });
            }

            bool isChecking = state is VpnChecking;

            return Dialog(
              alignment: Alignment.topCenter,
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.red.shade600.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                      child: Text(
                        "لطفاً VPN را خاموش کنید.",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (isChecking)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: () {
                          vpnBloc.add(CheckVpnEvent());
                        },
                        child: Container(
                          color: AppColors.appWhite.withAlpha(20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: const Text(
                            "تلاش مجدد",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VpnBloc, VpnState>(
      listener: (context, state) {
        if (!mounted) return;

        if (state is VpnConnected) {
          // اگر دیالوگ باز نیست، بازش کن
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!Navigator.of(context, rootNavigator: true).canPop()) {
              _showVpnDialog();
            }
          });
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                AppColors.splashGradiantColor2,
                AppColors.splashGradiantColor1,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.5),
              NeoBankLogo(
                logoColor: AppColors.appWhite,
                logoWidth: 98,
                logoHeight: 24,
                space: 5,
              ),
              const Spacer(),
              NeoBankVersion(textColor: AppColors.appWhite),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
