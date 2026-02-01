import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/Route/transaction_detail_args.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Core/Const/persian_date_format_H.dart';
import 'package:neo_bank_mehr_iran/Core/Const/persian_date_format_Y_M_D.dart';
import 'package:neo_bank_mehr_iran/Features/Statment_Page/Presentation/Bloc/Statement_Bloc/statement_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Statment_Page/Presentation/Bloc/Statement_Bloc/statement_state.dart';
import 'package:neo_bank_mehr_iran/Features/Statment_Page/Presentation/Component/transaction_detail_page.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class AllTransactionListWidget extends StatelessWidget {
  final String? depositNumber;

  const AllTransactionListWidget({super.key, required this.depositNumber});

  @override
  Widget build(BuildContext context) {
    if (depositNumber == null) {
      return const SizedBox();
    }

    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<StatementBloc, StatementState>(
      builder: (context, state) {
        if (state.status == StatementStateStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == StatementStateStatus.error) {
          return const Text(
            'خطا در دریافت تراکنش‌ها',
            style: TextStyle(color: Colors.red),
          );
        }

        if (state.allStatement.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'تراکنشی وجود ندارد',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.allStatement.length,
          itemBuilder: (context, index) {
            final item = state.allStatement[index];
            final isDeposit = item.actionDescription == 'واریز';

            return InkWell(
              onTap: () {
                context.push(
                  '/transaction_detail_page',
                  extra: TransactionDetailArgs(
                    title: item.actionDescription ?? '',
                    transferAmount: item.transferAmount!.toString(),
                    date: item.date.toString(),
                    description: item.description ?? '',
                  ),
                );
              },
              child: SizedBox(
                height: screenWidth < 400 ? 100 : 70,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          _ActionIcon(isDeposit: isDeposit),
                          const SizedBox(width: 12),
                          Expanded(child: _TransactionInfo(item: item)),
                        ],
                      ),
                    ),
                    Divider(height: 1, color: Theme.of(context).dividerColor),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final bool isDeposit;

  const _ActionIcon({required this.isDeposit});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDeposit
            ? Theme.of(context).colorScheme.inverseSurface
            : Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Icon(
        isDeposit ? Icons.arrow_downward : Icons.arrow_upward,
        size: 16,
        color: isDeposit
            ? Theme.of(context).colorScheme.onSecondary
            : Theme.of(context).colorScheme.onInverseSurface,
      ),
    );
  }
}

class _TransactionInfo extends StatelessWidget {
  final dynamic item;

  const _TransactionInfo({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.actionDescription ?? '',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            AppSpace.heightSpace_4,
            Text(
              formatPersianDateH(item.date.toString()),
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.transferAmount.toString().seRagham().toPersianDigit(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                ),
                AppSpace.widthSpace_5,
                Text(
                  'ریال',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                ),
              ],
            ),
            AppSpace.heightSpace_4,
            Text(
              formatPersianDateYMD(item.date.toString()),
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
