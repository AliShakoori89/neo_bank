import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/Payment_Page/Component/this_bank_card_payment.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Bloc/Profile_Bloc/profile_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Bloc/Profile_Bloc/profile_state.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../../../../Core/Const/app_colors.dart';
import '../../../../../../../Core/Const/app_space.dart';
import '../../../../../Data/Model/internet_package_model.dart';
import '../../../../Bloc/Wallet_Bloc/wallet_bloc.dart';
import '../../../../Bloc/Wallet_Bloc/wallet_event.dart';
import '../../../../Bloc/Wallet_Bloc/wallet_state.dart';
import '../Internet_package/Package_Card_Component/get_package_color.dart';
import '../custom_header.dart';
import 'Component/other_bank_card_payment.dart';
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
              AppSpace.heightSpace_24,
              _buildPaymentInfoCard(theme, widget.package),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    OtherBankCardPayment(amount: widget.amount, title: widget.title, package: widget.package),
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
                    ThisBankCardPayment(),
                  ],
                ),
              ),
              AppSpace.heightSpace_16,
            ],
          )
      ),
    );
  }

  Widget _buildPaymentInfoCard(ThemeData theme, InternetPackageModel package, ) {

    final packageTime = package.packageTime ?? '';

    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(
        right: 20,
        left: 20
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            getPackageColor(packageTime).withAlpha(30),
            getPackageColor(packageTime).withAlpha(10),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.payment, color: Theme.of(context).colorScheme.onPrimary, size: 28),
              AppSpace.widthSpace_8,
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryFixed,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (widget.package.description != null) ...[
            AppSpace.heightSpace_12,
            Text(
              widget.package.description!,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
          AppSpace.heightSpace_16,
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(20),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'مبلغ قابل پرداخت:',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primaryFixed,
                      fontSize: 14),
                ),
                Text(
                  '${widget.amount.toString().seRagham().toPersianDigit()} تومان',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryFixed,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
