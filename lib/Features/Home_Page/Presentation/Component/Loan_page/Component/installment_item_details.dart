import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../../../Core/Spacing/app_space.dart';
import '../../../../../../Core/Utils/Formatters/persian_date_format_y_m_d.dart';
import '../../../../../../Core/Widgets/custom_button.dart';
import '../../../../Domain/Entities/loan_entity.dart';
import '../../Charge_Internet_Page/Component/custom_header.dart';

class InstallmentItemDetails extends StatelessWidget {
  final String loanNumber;
  final InstallmentEntity installment;

  const InstallmentItemDetails({
    super.key,
    required this.loanNumber,
    required this.installment,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryFixed,
      body: SafeArea(
        child: Column(
          children: [
            const CustomHeader(title: 'جزئیات قسط پرداختی', hasBackArrow: true),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    /// کارت اطلاعات اصلی
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(10),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildDetailRow(
                            context,
                            'شماره تسهیلات',
                            loanNumber.toPersianDigit(),
                            Icons.numbers_rounded,
                          ),
                          const Divider(height: 32),
                          _buildDetailRow(
                            context,
                            'شماره قسط',
                            '${installment.installmentNo}'.toPersianDigit(),
                            Icons.tag_rounded,
                          ),
                          const Divider(height: 32),
                          _buildDetailRow(
                            context,
                            'مبلغ قسط',
                            '${installment.amount.toString().toPersianDigit().seRagham()} تومان',
                            Icons.account_balance_wallet_rounded,
                            valueColor: colors.primary,
                            isBold: true,
                          ),
                          const Divider(height: 32),
                          _buildDetailRow(
                            context,
                            'تاریخ سررسید',
                            formatPersianDateYMD(installment.dueDate.toString()),
                            Icons.calendar_month_rounded,
                          ),
                          const Divider(height: 32),
                          _buildDetailRow(
                            context,
                            'وضعیت',
                            installment.statusDescription,
                            Icons.info_outline_rounded,
                            valueColor: installment.status == 2 ? Colors.green : Colors.orange,
                          ),
                        ],
                      ),
                    ),
                    
                    AppSpace.heightSpace_42,
                    
                    /// توضیحات پرداخت
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colors.primary.withAlpha(10),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: colors.primary.withAlpha(20)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.lightbulb_outline_rounded, color: colors.primary, size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'مبلغ قسط مستقیماً از حساب متصل به تسهیلات کسر خواهد شد.',
                              style: TextStyle(
                                fontSize: 12,
                                color: colors.primaryFixed.withAlpha(200),
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            /// دکمه تایید پرداخت
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                buttonTitle: 'تایید و پرداخت',
                buttonOnPressed: () {
                  context.push(
                    '/payment_page',
                    extra: {
                      'amount': installment.amount.toString().toPersianDigit().seRagham(),
                      'title': 'پرداخت قسط',
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    Color? valueColor,
    bool isBold = false,
  }) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withAlpha(15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: theme.colorScheme.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: theme.colorScheme.onSurface.withAlpha(180),
            ),
          ),
        ),
        const Spacer(),
        Flexible(
          child: Text(
            value,
            maxLines: 4,
            textAlign: TextAlign.end,
            softWrap: true,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isBold
                  ? FontWeight.bold
                  : FontWeight.w600,
              color: valueColor ??
                  theme.colorScheme.primaryFixed,
            ),
          ),
        ),
      ],
    );
  }
}
