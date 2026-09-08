import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../../../Core/Theme/app_colors.dart';
import '../../../../../../../../Core/Spacing/app_space.dart';
import '../../../../../../../Profile_Page/Presentation/Bloc/Profile_Bloc/profile_bloc.dart';
import '../../../../../../../Profile_Page/Presentation/Bloc/Profile_Bloc/profile_state.dart';
import '../../../../../../Data/Model/internet_package_model.dart';
import '../../../../../Bloc/Internet_Packages_Bloc/get_internet_packages_bloc.dart';
import '../../../../../Bloc/Internet_Packages_Bloc/get_internet_packages_event.dart';
import '../../../../../Bloc/Internet_Packages_Bloc/get_internet_packages_state.dart';
import '../../../../../Bloc/Wallet_Bloc/wallet_bloc.dart';
import '../../../../../Bloc/Wallet_Bloc/wallet_event.dart';
import '../../../../../Bloc/Wallet_Bloc/wallet_state.dart';
import '../../../../Wallet_Page/Component/all_balance_widget.dart';
import '../../Internet_package/Package_Card_Component/Package_Details/Component/build_payment_button.dart';
import '../../Internet_package/Package_Card_Component/Package_Details/Component/handle_payment.dart';
import '../../Internet_package/Package_Card_Component/Package_Details/Component/show_error_dialog.dart';
import '../../Internet_package/Package_Card_Component/Package_Details/Component/show_success_dialog.dart';

class WalletPayment extends StatefulWidget {
  const WalletPayment({super.key,
    this.package,
    required this.destinationPhoneNumber,
    required this.amount,
    required this.title});

  final InternetPackage? package;
  final String amount;
  final String title;
  final String destinationPhoneNumber;

  @override
  State<WalletPayment> createState() => _WalletPaymentState();
}

class _WalletPaymentState extends State<WalletPayment> with WidgetsBindingObserver{

  bool _isLoading = false;
  bool showDepositContainer = false;
  bool showWithdrawContainer = false;

  Future<void> _handlePayment(selectedWalletAddress, sourcePhoneNumber) async {

    if (widget.package != null) {
      await PaymentHandler.handlePayment(
        context: context,
        selectedWalletAddress: selectedWalletAddress,
        sourcePhoneNumber: sourcePhoneNumber,
        destinationPhoneNumber: widget.destinationPhoneNumber,
        productCode: widget.package!.productCode,
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
    } else {
      // اینجا منطق پرداخت اقساط را پیاده‌سازی کنید
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('پرداخت اقساط از طریق کیف پول بزودی اضافه خواهد شد')),
      );
    }
  }

  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // وقتی کیبورد تغییر می‌کند، صفحه را ری‌لند می‌کند
    if (mounted) {
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {

          final String sourcePhoneNumber = state.mobileNumber ?? '';

          return BlocBuilder<WalletBloc, WalletState>(
              builder: (context, state)  {

                if (state.walletDetails.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                var selectedWalletAddress = state.walletDetails.first.address;

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
                          if (widget.package != null) {
                            showSuccessDialog(context, state.buyResult, widget.package!, selectedWalletAddress, sourcePhoneNumber);
                          }
                          context.read<InternetPackageBloc>().add(
                            ResetBuyStatus(),
                          );

                          context.read<WalletBloc>().add(
                            WalletDetailsPackagesEvent(),
                          );


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
                      child: LayoutBuilder(
                          builder: (context, constraints) {
                            return SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight,
                                ),
                                child: IntrinsicHeight(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SingleChildScrollView(
                                        physics: const NeverScrollableScrollPhysics(),
                                        child: Column(
                                          children: [
                                            AllBalanceWidget(),
                                            AppSpace.heightSpace_12,
                                            GestureDetector(
                                              onTap: (){
                                                context.push('/wallet_page');
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.withAlpha(25),
                                                    borderRadius: BorderRadius.all(Radius.circular(30))
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.add,
                                                      size: 20,
                                                      color: AppColors.splashGradiantColor1,
                                                    ),
                                                    AppSpace.widthSpace_5,
                                                    Text('افزایش موجودی',
                                                        style: TextStyle(
                                                          color: Theme.of(context).colorScheme.primaryFixed,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w700,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      buildPaymentButton(
                                          context,
                                          _isLoading,
                                          () => _handlePayment(
                                            selectedWalletAddress,
                                            sourcePhoneNumber,
                                          ),
                                          widget.package?.priceWithTax ?? widget.amount)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                      )
                  ),
                );
              }
          );
        }
    );
  }
}
