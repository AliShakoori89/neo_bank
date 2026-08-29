import 'package:flutter/material.dart';
import '../../../../../../../../../Core/Spacing/app_space.dart';
import 'Component/bank_details.dart';
import 'Component/bank_detector.dart';
import 'Component/bank_info.dart';
import 'Component/card_form_widget.dart';
import 'Component/loading_overlay.dart';

class OtherBankCardPayment extends StatefulWidget {
  const OtherBankCardPayment({
    super.key,
    required this.amount,
    required this.title,
    this.description,
    this.onSuccess,
    this.selectedWalletTitle,
  });

  final String amount;
  final String title;
  final String? description;
  final VoidCallback? onSuccess;
  final String? selectedWalletTitle;

  @override
  State<OtherBankCardPayment> createState() => _OtherBankCardPaymentState();
}

class _OtherBankCardPaymentState extends State<OtherBankCardPayment> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  bool _isLoading = false;
  BankInfo? _detectedBank;
  late final BankDetector _bankDetector;

  @override
  void initState() {
    super.initState();
    _bankDetector = BankDetector(banks);
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _handleCardNumberChanged(String cleanedCardNumber) {
    setState(() {
      _detectedBank = _bankDetector.detect(cleanedCardNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpace.heightSpace_24,
              CardFormWidget(
                cardNumberController: _cardNumberController,
                expiryDateController: _expiryDateController,
                cvvController: _cvvController,
                detectedBank: _detectedBank,
                onCardNumberChanged: _handleCardNumberChanged,
                banks: banks,
              ),
              AppSpace.heightSpace_24,
              // می‌توانید دکمه پرداخت را اینجا اضافه کنید
            ],
          ),
        ),
      ),
    );
  }
}