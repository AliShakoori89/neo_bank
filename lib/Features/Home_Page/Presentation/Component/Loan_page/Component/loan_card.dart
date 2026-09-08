import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'loan_installment_items.dart';

class LoanCard extends StatelessWidget {
  final dynamic loan;

  const LoanCard({
    super.key,
    required this.loan,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;



    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: colors.outline.withAlpha(35),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(
              theme.brightness == Brightness.dark ? 25 : 5,
            ),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// عنوان و وضعیت
            Row(
              children: [
                Expanded(
                  child: Text(
                    loan.title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: colors.primaryFixed,
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: colors.primary.withAlpha(12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    loan.loanStatusDescription,
                    style: TextStyle(
                      color: colors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// توضیحات
            Text(
              loan.description,
              style: TextStyle(
                fontSize: 13,
                color: colors.onSurface,
              ),
            ),

            const SizedBox(height: 16),

            /// مبلغ وام
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.primary.withAlpha(8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 22,
                    color: colors.primary,
                  ),

                  const SizedBox(width: 10),

                  Text(
                    'مبلغ تسهیلات',
                    style: TextStyle(
                      fontSize: 13,
                      color: colors.primaryFixed,
                    ),
                  ),

                  const Spacer(),

                  Text(
                    '${loan.amount.toString().toPersianDigit().seRagham()} تومان',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: colors.primary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            /// بخش اقساط (کشویی)
            Theme(
              data: theme.copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: EdgeInsets.zero,
                iconColor: colors.primary,
                collapsedIconColor: colors.onSurface,
                shape: const RoundedRectangleBorder(),
                collapsedShape: const RoundedRectangleBorder(),
                title: Row(
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 20,
                      color: colors.primary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'مشاهده اقساط',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: colors.primaryFixed,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: colors.primary.withAlpha(15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${loan.installments.length}'.toPersianDigit(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: colors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                children: [
                  const SizedBox(height: 10),
                  ...loan.installments.map<Widget>(
                        (installment) {
                      return InstallmentItem(
                        installment: installment,
                        loanEntity: loan,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

