import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Core/Spacing/app_space.dart';
import 'package:neo_bank_mehr_iran/Core/Widgets/custom_button.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/custom_header.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class GiftDetailsPage extends StatelessWidget {
  const GiftDetailsPage({
    super.key,
    required this.phoneNumber,
    required this.imgPath,
    required this.cardTitle,
    required this.amount,
    required this.message,
  });

  final String phoneNumber;
  final String imgPath;
  final String cardTitle;
  final String amount;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
      body: SafeArea(
        child: Column(
          children: [
            const CustomHeader(title: 'جزئیات کارت هدیه', hasBackArrow: true),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          imgPath,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              color: Colors.grey[300],
                              child: const Icon(Icons.image_not_supported, size: 50),
                            );
                          },
                        ),
                      ),
                    ),
                    AppSpace.heightSpace_24,
                    _buildInfoRow(context, 'عنوان کارت:', cardTitle),
                    _buildInfoRow(context, 'شماره تماس گیرنده:', phoneNumber.toPersianDigit()),
                    _buildInfoRow(context, 'مبلغ:', '$amount ریال'),
                    AppSpace.heightSpace_16,
                    Text(
                      'متن پیام:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primaryFixed,
                      ),
                    ),
                    AppSpace.heightSpace_8,
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        message,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                buttonTitle: 'تایید و پرداخت',
                buttonOnPressed: () {

                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primaryFixed,
            ),
          ),
        ],
      ),
    );
  }
}
