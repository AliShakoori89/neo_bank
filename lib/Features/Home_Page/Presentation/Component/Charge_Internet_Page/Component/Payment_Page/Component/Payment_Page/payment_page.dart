import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../../Core/Theme/app_colors.dart';
import '../../../../../../../../../Core/Spacing/app_space.dart';
import '../../../../../../../../Profile_Page/Presentation/Bloc/Profile_Bloc/profile_bloc.dart';
import '../../../../../../../../Profile_Page/Presentation/Bloc/Profile_Bloc/profile_event.dart';
import '../../../../../../../Data/Model/internet_package_model.dart';
import '../../../../../../Bloc/Wallet_Bloc/wallet_bloc.dart';
import '../../../../../../Bloc/Wallet_Bloc/wallet_event.dart';
import '../../../custom_header.dart';
import '../Other_Bank_Card_Payment/other_bank_card_payment.dart';
import '../This_Bank_Card_Payment/this_bank_card_payment.dart';
import '../wallet_payment.dart';
import 'Component/build_charge_package_payment_info_card.dart';
import 'Component/build_loan_installment_payment_info_card.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, required this.amount, required this.title, this.package, this.phoneNumber});

  final String amount;
  final String title;
  final InternetPackage? package;
  final String? phoneNumber;

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
    context.read<ProfileBloc>().add(
        GetProfileEventEvent());
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

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: theme.colorScheme.onPrimaryFixed,
        body: SafeArea(
          child: Column(
            children: [
              CustomHeader(title: 'پرداخت', hasBackArrow: false,),
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
              AppSpace.heightSpace_24,
              widget.package != null
                  ? buildChargePackagePaymentInfoCard(context, theme, widget.package!, widget.title, widget.amount)
                  : buildLoanInstallmentPaymentInfoCard(context, theme, widget.title, widget.amount),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    OtherBankCardPayment(amount: widget.amount, title: widget.title),
                    WalletPayment(
                        amount: widget.amount,
                        title: widget.title,
                        package: widget.package,
                        destinationPhoneNumber: widget.phoneNumber ?? ''),
                    ThisBankCardPayment(),
                  ],
                ),
              ),
              AppSpace.heightSpace_16,
            ],
          ),
        )
    );
  }
}
