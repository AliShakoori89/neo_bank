import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/Theme/app_colors.dart';
import '../../../Core/Widgets/app_snack_bar_with_button.dart';
import '../../../Core/Widgets/neo_bank_logo.dart';
import '../../../Core/Widgets/neo_bank_version.dart';
import 'VPN_Bloc/vpn_bloc.dart';
import 'VPN_Bloc/vpn_event.dart';
import 'VPN_Bloc/vpn_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {

  late VpnBloc vpnBloc;
  late Animation<Offset> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    vpnBloc = context.read<VpnBloc>();

    // بررسی اولیه VPN بعد از render شدن صفحه
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vpnBloc.add(CheckVpnEvent());
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
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
            if (state is VpnConnected && state.force == true) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (Navigator.canPop(context)) Navigator.pop(context);
              });
            }

            bool isChecking = state is VpnChecking;

            return AppSnackBarWithButton(
                errorText: "لطفاً VPN را خاموش کنید.",
                isLoading: isChecking,
                handleRetry: () {context.read<VpnBloc>().add(CheckVpnEvent());},
                animation: _animation);

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
