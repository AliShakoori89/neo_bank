import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Model/internet_package_model.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Wallet_Bloc/wallet_event.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../Bloc/Wallet_Bloc/wallet_bloc.dart';
import 'build_description_section.dart';
import 'build_details_section.dart';
import 'build_main_package_card.dart';
import 'build_terms_section.dart';
import 'format_price.dart';


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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final package = widget.package;

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryFixed,
      appBar: AppBar(
        title: const Text('جزئیات بسته اینترنت'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.colorScheme.onPrimaryFixed,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // کارت اصلی بسته
                  buildMainPackageCard(context, package),
                  AppSpace.heightSpace_16,

                  // جزئیات کامل بسته
                  buildDetailsSection(context, package, widget.phoneNumber),
                  AppSpace.heightSpace_16,

                  // توضیحات تکمیلی
                  if (package.description != null &&
                      package.description!.isNotEmpty)
                    buildDescriptionSection(context, package),
                  AppSpace.heightSpace_16,

                  // شرایط و ضوابط
                  buildTermsSection(context),
                ],
              ),
            ),
          ),

          // دکمه پرداخت (در پایین صفحه ثابت)
          _buildPaymentButton(context),
        ],
      ),
    );
  }

  // دکمه پرداخت
  Widget _buildPaymentButton(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimaryFixed,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: _isLoading ? null : _handlePayment,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.splashGradiantColor2,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: _isLoading
              ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.payment, size: 20),
              const SizedBox(width: 8),
              Text(
                'پرداخت ${formatPrice(widget.package.priceWithTax).toPersianDigit()} تومان',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // پردازش پرداخت
  Future<void> _handlePayment() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: پیاده‌سازی منطق پرداخت
      // مثال:
      // final result = await context.read<PaymentBloc>().makePayment(
      //   package: widget.package,
      //   phoneNumber: widget.phoneNumber,
      // );

      // شبیه‌سازی درخواست
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        // context.read<WalletBloc>().add(BuyPackagesEvent());
        // نمایش پیام موفقیت
        _showSuccessDialog();
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog(e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // نمایش دیالوگ موفقیت
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Column(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 60,
              ),
              SizedBox(height: 16),
              Text('پرداخت موفق'),
            ],
          ),
          content: Text(
            'بسته ${widget.package.packageTime} با موفقیت خریداری شد.\n'
                'پیامک تأیید به شماره ${widget.phoneNumber} ارسال شد.',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop(); // بستن دیالوگ
                context.pop(); // برگشت به صفحه قبل
              },
              child: const Text('باشه'),
            ),
          ],
        );
      },
    );
  }

  // نمایش دیالوگ خطا
  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(Icons.error, color: Colors.red),
              SizedBox(width: 8),
              Text('خطا در پرداخت'),
            ],
          ),
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('باشه'),
            ),
          ],
        );
      },
    );
  }

}