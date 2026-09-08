import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../../../../Core/Spacing/app_space.dart';
import '../../../../../../../../../Core/Widgets/custom_button.dart';
import '../../../../../../../Data/Model/internet_package_model.dart';
import '../../../../../../../Data/Model/wallet_model.dart';
import '../../../../../../Bloc/Wallet_Bloc/wallet_bloc.dart';
import '../../../../../../Bloc/Wallet_Bloc/wallet_event.dart';
import '../../../custom_header.dart';
import '../build_description_section.dart';
import '../build_details_section.dart';
import '../build_main_package_card.dart';
import '../build_terms_section.dart';

class InternetPackageDetailsPage extends StatefulWidget {
  const InternetPackageDetailsPage({
    super.key,
    required this.package,
    required this.phoneNumber,
    required this.operatorCode,
  });

  final InternetPackage package;
  final String phoneNumber;
  final int operatorCode;

  @override
  State<InternetPackageDetailsPage> createState() =>
      _InternetPackageDetailsPageState();
}

class _InternetPackageDetailsPageState
    extends State<InternetPackageDetailsPage> {
  WalletModel? walletModel;

  @override
  void initState() {
    context.read<WalletBloc>().add(WalletDetailsPackagesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final package = widget.package;

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryFixed,
      body: SafeArea(
        child: Column(
          children: [
            CustomHeader(title: 'جزئیات بسته اینترنت', hasBackArrow: false),
            AppSpace.heightSpace_12,
            Expanded(
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
                          if (widget.package.description.isNotEmpty)
                            buildDescriptionSection(context, widget.package),
                          AppSpace.heightSpace_16,
                          buildTermsSection(context),
                          // if (_selectedWalletTitle != null) ...[
                          //   AppSpace.heightSpace_16,
                          //   buildSelectedWalletInfo(_selectedWalletTitle!, _selectWallet),
                          // ],
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 16,
                    ),
                    child: CustomButton(
                      buttonTitle: 'تایید و پرداخت',
                      buttonOnPressed: () {
                        // ارسال اطلاعات به صفحه پرداخت
                        context.push(
                          '/payment_page',
                          extra: {
                            'phoneNumber': widget.phoneNumber,
                            'amount': package.priceWithTax.toString(),
                            'title': 'خرید بسته اینترنت ${package.packageTime}',
                            'package': package,
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> _selectWallet() async {
  //   final result = await WalletSelector.selectWallet(
  //     context: context,
  //     currentSelectedIndex: _selectedCardIndex,
  //   );
  //
  //   if (result != null && mounted) {
  //     setState(() {
  //       _selectedWalletAddress = result['address'];
  //       _selectedWalletTitle = result['title'];
  //       // باید ایندکس کارت انتخاب شده را نیز ذخیره کنید
  //       // اگر نیاز دارید ایندکس را هم در نتیجه برگردانید
  //     });
  //   }
  // }

}

