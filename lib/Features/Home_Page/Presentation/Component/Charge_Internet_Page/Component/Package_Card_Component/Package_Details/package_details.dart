import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/internet_package_model.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Internet_Packages_Bloc/get_internet_packages_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Internet_Packages_Bloc/get_internet_packages_event.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Internet_Packages_Bloc/get_internet_packages_state.dart';
import '../../../../../../Data/Model/wallet_model.dart';
import '../../../../../Bloc/Wallet_Bloc/wallet_bloc.dart';
import '../../../../../Bloc/Wallet_Bloc/wallet_event.dart';
import '../../custom_header.dart';
import '../build_description_section.dart';
import '../build_details_section.dart';
import '../build_main_package_card.dart';
import '../build_terms_section.dart';
import 'Component/build_payment_button.dart';
import 'Component/build_selected_wallet_info.dart';
import 'Component/handle_payment.dart';
import 'Component/select_wallet.dart';
import 'Component/show_error_dialog.dart';
import 'Component/show_success_dialog.dart';

class InternetPackageDetailsPage extends StatefulWidget {
  const InternetPackageDetailsPage({
    super.key,
    required this.package,
    required this.phoneNumber,
    required this.operatorCode,
  });

  final InternetPackageModel package;
  final String phoneNumber;
  final int operatorCode;

  @override
  State<InternetPackageDetailsPage> createState() =>
      _InternetPackageDetailsPageState();
}

class _InternetPackageDetailsPageState
    extends State<InternetPackageDetailsPage> {
  bool _isLoading = false;
  final int _selectedCardIndex = -1;
  WalletModel? walletModel;
  String? _selectedWalletAddress;
  String? _selectedWalletTitle;

  @override
  void initState() {
    context.read<WalletBloc>().add(WalletDetailsPackagesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final package = widget.package;

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimaryFixed,
        body: Column(
          children: [
            CustomHeader(title: 'جزئیات بسته اینترنت'),
            AppSpace.heightSpace_12,
            Expanded(
              child: BlocListener<InternetPackageBloc, InternetPackageState>(
                listenWhen: (previous, current) =>
                previous.buyStatus != current.buyStatus,
                listener: (context, state) {
                  if (state.buyStatus.isSuccess) {
                    setState(() {
                      _isLoading = false;
                    });
                    showSuccessDialog(context, state.buyResult, package, _selectedWalletTitle, widget.phoneNumber);
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
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildMainPackageCard(context, widget.package),
                            AppSpace.heightSpace_16,
                            buildDetailsSection(context, widget.package,
                                widget.phoneNumber),
                            AppSpace.heightSpace_16,
                            if (widget.package.description != null &&
                                widget.package.description!.isNotEmpty)
                              buildDescriptionSection(context, widget.package),
                            AppSpace.heightSpace_16,
                            buildTermsSection(context),
                            if (_selectedWalletTitle != null) ...[
                              AppSpace.heightSpace_16,
                              buildSelectedWalletInfo(_selectedWalletTitle!, _selectWallet),
                            ],
                          ],
                        ),
                      ),
                    ),
                    buildPaymentButton(context, _isLoading, _handlePayment, package.priceWithTax),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
// تغییر متد _handlePayment
  Future<void> _handlePayment() async {
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

  Future<void> _selectWallet() async {
    final result = await WalletSelector.selectWallet(
      context: context,
      currentSelectedIndex: _selectedCardIndex,
    );

    if (result != null && mounted) {
      setState(() {
        _selectedWalletAddress = result['address'];
        _selectedWalletTitle = result['title'];
        // باید ایندکس کارت انتخاب شده را نیز ذخیره کنید
        // اگر نیاز دارید ایندکس را هم در نتیجه برگردانید
      });
    }
  }

}

