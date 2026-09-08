import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../../../Core/Utils/Formatters/persian_date_format_y_m_d.dart';
import '../../../../Domain/Entities/loan_entity.dart';

class InstallmentItem extends StatelessWidget {
  final dynamic installment;
  final LoanEntity loanEntity;

  const InstallmentItem({
    super.key,
    required this.installment,
    required this.loanEntity
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.outline.withAlpha(25),
        ),
      ),
      child: Row(
        children: [
          /// شماره قسط
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: colors.primary.withAlpha(12),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '${installment.installmentNo}'.toPersianDigit(),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: colors.primary,
              ),
            ),
          ),

          const SizedBox(width: 10),

          /// مبلغ
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'قسط ${installment.installmentNo.toString().toPersianDigit()}',
                  style: TextStyle(
                    fontSize: 11,
                    color: colors.onSurface,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  '${installment.amount.toString().toPersianDigit().seRagham()} تومان',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: colors.primaryFixed,
                  ),
                ),
              ],
            ),
          ),

          /// تاریخ و وضعیت
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatPersianDateYMD(installment.dueDate.toString()),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: colors.primaryFixed,
                ),
              ),

              const SizedBox(height: 4),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: colors.primary.withAlpha(10),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  installment.statusDescription,
                  style: TextStyle(
                    fontSize: 10,
                    color: colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 12),

          /// دکمه پرداخت (فقط برای اقساط پرداخت نشده)
          if (installment.status != 2) // فرض بر این که ۲ یعنی پرداخت شده
            SizedBox(
              height: 34,
              child: ElevatedButton(
                onPressed: () {

                  print('INSTALLMENT: $installment');
                  print('LOAN NUMBER: ${loanEntity.loanNumber}');
                  print('LOAN NUMBER TYPE: ${loanEntity.loanNumber.runtimeType}');

                  context.push(
                    '/installment_item_details',
                    extra: {
                      'installment': installment,
                      'loanNumber': loanEntity.loanNumber,
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'پرداخت',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
