import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank/Features/Statement_Page/Presentation/Component/statement_list_shimmer.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../Core/Routes/transaction_detail_args.dart';
import '../../../../Core/Spacing/app_space.dart';
import '../../../../Core/Utils/Formatters/persian_date_format_y_m_d.dart';
import '../../../../Core/Widgets/no_data_receive.dart';
import '../../../../Core/Utils/Formatters/persian_date_format_h.dart';
import '../Bloc/Statement_Bloc/statement_bloc.dart';
import '../Bloc/Statement_Bloc/statement_event.dart';
import '../Bloc/Statement_Bloc/statement_state.dart';

class AllTransactionListWidget extends StatelessWidget {
  final String? depositNumber;

  const AllTransactionListWidget({super.key, required this.depositNumber});

  @override
  Widget build(BuildContext context) {
    if (depositNumber == null) {
      return const SizedBox();
    }

    return BlocBuilder<StatementBloc, StatementState>(
      builder: (context, state) {
        if (state.status == StatementStateStatus.loading) {
          return StatementListShimmer(itemCount: 5,);
        }

        if (state.status == StatementStateStatus.error) {
          return Center(child: NoDataReceive(description: 'خطا در دریافت تراکنش‌ها'));
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
          itemCount: state.allStatement.length + (state.hasMore ? 1 : 0),
          itemExtent: 70,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index < state.allStatement.length) {
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        _ActionIcon(isDeposit: isDeposit),
                        const SizedBox(width: 12),
                        Expanded(child: _TransactionInfo(item: item)),
                      ],
                    ),
                    Divider(height: 1, color: Theme.of(context).dividerColor),
                  ],
                )
              );
            }

            /// 🔽 مشاهده بیشتر
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: state.isLoadingMore
                    ? const LinearProgressIndicator(
                  minHeight: 1,
                )
                    : TextButton(
                  onPressed: () {
                    context.read<StatementBloc>().add(
                      LoadMoreStatementEvent(depositNumber!),
                    );
                  },
                  child: Text('مشاهده بیشتر ...',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiary
                    ),
                  ),
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
