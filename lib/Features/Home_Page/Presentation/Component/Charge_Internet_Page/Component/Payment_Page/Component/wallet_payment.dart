import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../Data/Model/internet_package_model.dart';
import '../../../../../Bloc/Internet_Packages_Bloc/get_internet_packages_bloc.dart';
import '../../../../../Bloc/Internet_Packages_Bloc/get_internet_packages_event.dart';
import '../../../../../Bloc/Internet_Packages_Bloc/get_internet_packages_state.dart';
import '../../../../Wallet_Page/Component/all_balance_widget.dart';
import '../../Internet_package/Package_Card_Component/Package_Details/Component/build_payment_button.dart';
import '../../Internet_package/Package_Card_Component/Package_Details/Component/handle_payment.dart';
import '../../Internet_package/Package_Card_Component/Package_Details/Component/show_error_dialog.dart';
import '../../Internet_package/Package_Card_Component/Package_Details/Component/show_success_dialog.dart';

class WalletPayment extends StatefulWidget {
  const WalletPayment({super.key, required this.package, required this.sourcePhoneNumber, required this.destinationPhoneNumber, required this.amount, required this.title, required this.selectedWalletAddress});

  final InternetPackageModel package;
  final String sourcePhoneNumber;
  final String amount;
  final String title;
  final String selectedWalletAddress;
  final String destinationPhoneNumber;

  @override
  State<WalletPayment> createState() => _WalletPaymentState();
}

class _WalletPaymentState extends State<WalletPayment> {

  bool _isLoading = false;

  Future<void> _handlePayment() async {

    await PaymentHandler.handlePayment(
      context: context,
      selectedWalletAddress: widget.selectedWalletAddress,
      sourcePhoneNumber: widget.sourcePhoneNumber,
      destinationPhoneNumber: widget.destinationPhoneNumber,
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


  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(
        top: 40,
          right: 20,
          left: 20
      ),
      child: BlocListener<InternetPackageBloc, InternetPackageState>(
        listenWhen: (previous, current) =>
        previous.buyStatus != current.buyStatus,
          listener: (context, state) {
            if (state.buyStatus.isSuccess) {
              setState(() {
                _isLoading = false;
              });
              showSuccessDialog(context, state.buyResult, widget.package, widget.selectedWalletAddress, widget.sourcePhoneNumber);
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AllBalanceWidget(),
            buildPaymentButton(context, _isLoading, _handlePayment ,widget.package.priceWithTax)
          ],
        )
      ),
    );
  }
}
