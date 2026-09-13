import 'package:flutter/material.dart';
import '../../../../Core/Spacing/app_space.dart';
import '../../../../Core/Theme/app_colors.dart';
import '../../../../Core/Widgets/custom_button.dart';
import '../../../Home_Page/Presentation/Component/Charge_Internet_Page/Component/custom_header.dart';

class InvoiceDetails extends StatefulWidget {
  final String title;
  final IconData? icon;
  final Color? color;

  const InvoiceDetails({
    super.key,
    required this.title,
    this.icon,
    this.color,
  });

  @override
  State<InvoiceDetails> createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {
  final TextEditingController billIdController = TextEditingController();
  final TextEditingController paymentIdController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    billIdController.dispose();
    paymentIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = widget.color ?? AppColors.splashGradiantColor1;

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryFixed,
      body: SafeArea(
        child: Column(
          children: [
            CustomHeader(
              title: widget.title,
              hasBackArrow: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Icon and Title Header ---
                      Center(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(25),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: primaryColor.withAlpha(50),
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                widget.icon ?? Icons.receipt_long_rounded,
                                color: primaryColor,
                                size: 48,
                              ),
                            ),
                            AppSpace.heightSpace_16,
                            Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primaryFixed,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      AppSpace.heightSpace_42,

                      Text(
                        'شناسه قبض را وارد کنید:',
                        style: TextStyle(
                          fontSize: 14,
                          color: theme.colorScheme.primaryFixed,
                        ),
                      ),
                      AppSpace.heightSpace_8,
                      _buildTextField(
                        controller: billIdController,
                        hintText: 'شناسه قبض',
                        primaryColor: primaryColor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لطفا شناسه قبض را وارد کنید';
                          }
                          return null;
                        },
                      ),
                      
                      AppSpace.heightSpace_24,
                      
                      Text(
                        'شناسه پرداخت را وارد کنید:',
                        style: TextStyle(
                          fontSize: 14,
                          color: theme.colorScheme.primaryFixed,
                        ),
                      ),
                      AppSpace.heightSpace_8,
                      _buildTextField(
                        controller: paymentIdController,
                        hintText: 'شناسه پرداخت',
                        primaryColor: primaryColor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لطفا شناسه پرداخت را وارد کنید';
                          }
                          return null;
                        },
                      ),
                      
                      AppSpace.heightSpace_48,
                      
                      CustomButton(
                        buttonTitle: 'بررسی مقادیر',
                        buttonOnPressed: () {
                          if (formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('در حال بررسی اطلاعات ${widget.title}...'),
                                backgroundColor: primaryColor,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required Color primaryColor,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.outline,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 14,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14,
          color: Theme.of(context).colorScheme.surface,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.surfaceDim,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.surfaceDim,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: primaryColor,
            width: 2,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
