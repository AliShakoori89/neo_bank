import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/Route/transaction_detail_args.dart';
import 'package:neo_bank_mehr_iran/Core/Const/no_data_receive.dart';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Presentation/Bloc/Statement_Bloc/statement_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Presentation/Bloc/Statement_Bloc/statement_state.dart';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Presentation/Component/statement_list_shimmer.dart';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Presentation/Component/transaction_info.dart';
import '../Bloc/Statement_Bloc/statement_event.dart';
import 'action_icon.dart';

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
          return StatementListShimmer();
        }

        if (state.status == StatementStateStatus.error) {
          return NoDataReceive(description: 'خطا در دریافت تراکنش‌ها');
        }

        if (state.allStatement.isEmpty) {
          return NoDataReceive(description: 'تراکنشی وجود ندارد');
        }

        return ListView.builder(
          itemCount: state.hasMore ? state.allStatement.length + 1 : state.allStatement.length,
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
                child: SizedBox(
                  height: MediaQuery.of(context).size.width < 400 ? 100 : 70,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            ActionIcon(isDeposit: isDeposit),
                            const SizedBox(width: 12),
                            Expanded(child: TransactionInfo(item: item)),
                          ],
                        ),
                      ),
                      Divider(height: 1, color: Theme.of(context).dividerColor),
                    ],
                  ),
                ),
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


