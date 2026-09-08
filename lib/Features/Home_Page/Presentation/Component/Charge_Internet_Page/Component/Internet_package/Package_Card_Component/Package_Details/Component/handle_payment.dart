import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank/Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/Internet_package/Package_Card_Component/Package_Details/Component/select_wallet.dart';
import 'package:neo_bank/Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/Internet_package/Package_Card_Component/Package_Details/Component/show_error_dialog.dart';

import '../../../../../../../Bloc/Internet_Packages_Bloc/get_internet_packages_bloc.dart';
import '../../../../../../../Bloc/Internet_Packages_Bloc/get_internet_packages_event.dart';

class PaymentHandler {
  static Future<void> handlePayment({
    required BuildContext context,
    required String? selectedWalletAddress,
    required String sourcePhoneNumber,
    required String destinationPhoneNumber,
    required int productCode,
    required Function(bool) setLoading,
    required Function() onSuccess,
    required Function(String, {int? errorCode}) onError,
  }) async {
    String? walletAddress = selectedWalletAddress;

    // اگر کیف پول انتخاب نشده، اول دیالوگ انتخاب را باز کن
    if (walletAddress == null) {
      final result = await WalletSelector.selectWallet(
        context: context,
        currentSelectedIndex: -1,
      );

      if (result != null && context.mounted) {
        walletAddress = result['address'];
        // به روز رسانی در state اصلی
        if (context.mounted) {
          // اینجا باید state اصلی را به روز کنید
          // از طریق callback این کار را انجام می‌دهیم
        }
      }

      // اگر باز هم انتخاب نکرد، برگرد
      if (walletAddress == null && context.mounted) {
        if (context.mounted) {
          showErrorDialog(context, 'لطفاً ابتدا کیف پول خود را انتخاب کنید');
        }
        return;
      }
    }

    setLoading(true);

    if (context.mounted) {

      context.read<InternetPackageBloc>().add(
        BuyInternetPackage(
          sourceMobileNumber: sourcePhoneNumber,
          walletAddress: walletAddress!,
          productCode: productCode,
          destMobileNumber: destinationPhoneNumber,
        ),
      );
    }
  }
}