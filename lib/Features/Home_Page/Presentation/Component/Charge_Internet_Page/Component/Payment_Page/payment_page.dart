import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Bloc/Profile_Bloc/profile_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Bloc/Profile_Bloc/profile_state.dart';
import '../../../../../../../Core/Const/app_colors.dart';
import '../../../../../../../Core/Const/app_space.dart';
import '../../../../../Data/Model/internet_package_model.dart';
import '../../../../Bloc/Wallet_Bloc/wallet_bloc.dart';
import '../../../../Bloc/Wallet_Bloc/wallet_event.dart';
import '../../../../Bloc/Wallet_Bloc/wallet_state.dart';
import '../custom_header.dart';
import 'Component/bank_card_payment.dart';
import 'Component/wallet_payment.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, required this.amount, required this.title, required this.package, required this.phoneNumber});

  final String amount;
  final String title;
  final InternetPackageModel package;
  final String phoneNumber;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>  with SingleTickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().add(
        WalletDetailsPackagesEvent());
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: theme.colorScheme.onPrimaryFixed,
          body: Column(
            children: [
              CustomHeader(title: 'شارژ و اینترنت'),
              SizedBox(
                height: 56,
                width: double.infinity,
                child: TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'کارت بانکی'),
                    Tab(text: 'کیف پول'),
                    Tab(text: 'حساب بانکی'),
                  ],
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerHeight: 0,
                  labelColor: AppColors.splashGradiantColor2,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: AppColors.splashGradiantColor2,
                  indicatorWeight: 1.0,
                  splashFactory: NoSplash.splashFactory,
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    BankCardPayment(amount: widget.amount, title: widget.title, package: widget.package),
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {

                        final String sourcePhoneNumber = state.mobileNumber!;

                        return BlocBuilder<WalletBloc, WalletState>(
                            builder: (context, state)  {
                              return WalletPayment(
                                amount: widget.amount,
                                title: widget.title,
                                package: widget.package,
                                sourcePhoneNumber: sourcePhoneNumber,
                                destinationPhoneNumber: widget.phoneNumber,
                                selectedWalletAddress: state.walletDetails!.first.address ?? '');
                            }
                        );
                      }
                    ),
                    BankCardPayment(amount: widget.amount, title: widget.title, package: widget.package),
                  ],
                ),
              ),
              AppSpace.heightSpace_16,
            ],
          )
      ),
    );
  }

}
