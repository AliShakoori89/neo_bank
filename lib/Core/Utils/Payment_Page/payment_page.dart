import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/Payment_Page/Component/bank_card.dart';
import '../../../Features/Home_Page/Data/Model/internet_package_model.dart';
import '../../../Features/Home_Page/Presentation/Bloc/Internet_Packages_Bloc/get_internet_packages_bloc.dart';
import '../../../Features/Home_Page/Presentation/Bloc/Internet_Packages_Bloc/get_internet_packages_event.dart';
import '../../../Features/Home_Page/Presentation/Bloc/Internet_Packages_Bloc/get_internet_packages_state.dart';
import '../../../Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/Internet_package/Package_Card_Component/Package_Details/Component/build_payment_button.dart';
import '../../../Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/Internet_package/Package_Card_Component/Package_Details/Component/handle_payment.dart';
import '../../../Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/Internet_package/Package_Card_Component/Package_Details/Component/show_error_dialog.dart';
import '../../../Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/Internet_package/Package_Card_Component/Package_Details/Component/show_success_dialog.dart';
import '../../../Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/custom_header.dart';
import '../../Const/app_colors.dart';
import '../../Const/app_space.dart';

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
  String? _selectedWalletAddress;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
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
              BlocListener<InternetPackageBloc, InternetPackageState>(
                listenWhen: (previous, current) =>
                previous.buyStatus != current.buyStatus,
                  listener: (context, state) {
                    if (state.buyStatus.isSuccess) {
                      setState(() {
                        _isLoading = false;
                      });
                      showSuccessDialog(context, state.buyResult, widget.package, _selectedWalletAddress, widget.phoneNumber);
                      Future.delayed(const Duration(seconds: 1), () {
                        if (mounted) {
                          context
                              .read<InternetPackageBloc>()
                              .add(ResetBuyStatus());
                        }
                      });
                    } else if (state.buyStatus.isFailure) {
                      setState(() {
                        _isLoading = false;
                      });
                      showErrorDialog(
                        context,
                        state.errorMessage ?? 'خطا در خرید بسته',
                        errorCode: state.errorCode,
                      );
                      context.read<InternetPackageBloc>().add(ResetBuyStatus());
                    } else if (state.buyStatus.isError) {
                      setState(() {
                        _isLoading = false;
                      });
                      showErrorDialog(
                        context,
                        state.errorMessage ?? 'خطا در ارتباط با سرور',
                      );
                      context.read<InternetPackageBloc>().add(ResetBuyStatus());
                    }
                  },
                child: Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      BankCard(amount: widget.amount, title: widget.title, package: widget.package, phoneNumber: widget.phoneNumber,),
                      BankCard(amount: widget.amount, title: widget.title, package: widget.package, phoneNumber: widget.phoneNumber,),
                      BankCard(amount: widget.amount, title: widget.title, package: widget.package, phoneNumber: widget.phoneNumber,),
                    ],
                  ),
                )
              ),
              _tabController.index == 1 ? buildPaymentButton(context, _isLoading, _handlePayment ,widget.package.priceWithTax) : _tabController.index == 2 ? Container() : Container(),
              AppSpace.heightSpace_16,
            ],
          )
      ),
    );
  }

  Future<void> _handlePayment() async {
    print(_selectedWalletAddress);
    print(widget.phoneNumber);
    print(widget.package.productCode!);
    print(_tabController.index);
    await PaymentHandler.handlePayment(
      context: context,
      selectedWalletAddress: _selectedWalletAddress,
      phoneNumber: widget.phoneNumber,
      productCode: widget.package.productCode!,
      setLoading: (isLoading) {
        setState(() {
          _isLoading = isLoading;
        });
      },
      onSuccess: () {
        // در صورت نیاز به عملیات اضافی بعد از موفقیت
      },
      onError: (error, {errorCode}) {
        // در صورت نیاز به عملیات اضافی بعد از خطا
      },
    );
  }
}
