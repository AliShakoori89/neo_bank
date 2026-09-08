import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank/Features/Home_Page/Presentation/Component/Transaction_List_Widget/transaction_list_shimmer.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../../Core/Routes/transaction_detail_args.dart';
import '../../../../../Core/Spacing/app_space.dart';
import '../../../../../Core/Utils/Formatters/persian_date_format_m_d.dart';
import '../../../../../Core/Widgets/custom_card.dart';
import '../../../../../Core/Widgets/error_refresh_widget.dart';
import '../../Bloc/Last_Transaction_Bloc/last_transaction_bloc.dart';
import '../../Bloc/Last_Transaction_Bloc/last_transaction_event.dart';
import '../../Bloc/Last_Transaction_Bloc/last_transaction_state.dart';

class TransactionsListWidget extends StatefulWidget {
  const TransactionsListWidget({super.key, required this.depositNumber});

  final String? depositNumber;

  @override
  State<TransactionsListWidget> createState() => _TransactionsListWidgetState();
}

class _TransactionsListWidgetState extends State<TransactionsListWidget> {

  String? _lastDeposit;

  @override
  void didUpdateWidget(covariant TransactionsListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.depositNumber != null &&
        widget.depositNumber != _lastDeposit) {
      _lastDeposit = widget.depositNumber;

      BlocProvider.of<LastTransactionBloc>(context).add(
        FetchLastTransactionEvent(
          depositNumber: widget.depositNumber!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.depositNumber == null) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 0, right: 25),
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  children: [
                    Text(
                      'تراکنش‌ها',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryFixed,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Center( // 👈 آیکون رو وسط می‌کنه
                      child: IconButton(
                        padding: EdgeInsets.all(5), // 👈 padding داخلی IconButton رو حذف می‌کنیم
                        constraints: BoxConstraints(), // 👈 محدودیت سایز خودش رو حذف
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.white.withAlpha(50)),
                        ),
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.primaryFixed,
                          size: 16,
                        ),
                        onPressed: () {
                          context.push('/statement_page');
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            AppSpace.heightSpace_90,
            Text('خطا در دریافت اطلاعات.')
          ],
        ),
      ); // یا shimmer
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 0, right: 25),
            child: Align(
              alignment: Alignment.centerRight,
              child: Row(
                children: [
                  Text(
                    'تراکنش‌ها',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primaryFixed,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Center( // 👈 آیکون رو وسط می‌کنه
                    child: IconButton(
                      padding: EdgeInsets.all(5), // 👈 padding داخلی IconButton رو حذف می‌کنیم
                      constraints: BoxConstraints(), // 👈 محدودیت سایز خودش رو حذف
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.white.withAlpha(50)),
                      ),
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).colorScheme.primaryFixed,
                        size: 16,
                      ),
                      onPressed: () {
                        context.push('/statement_page');
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          AppSpace.heightSpace_12,
          BlocBuilder<LastTransactionBloc, LastTransactionState>(
            // buildWhen: (prev, curr) =>
            //     prev.topStatement != curr.topStatement ||
            //     prev.status != curr.status,
            builder: (context, state) {
              if (state.status == SLastTransactionStatus.loading &&
                  state.topStatement.isEmpty) {
                return TransactionListShimmer();
              }

              if (state.status == SLastTransactionStatus.error) {
                return ErrorRefreshWidget(
                  refreshFunction: () {
                    context.read<LastTransactionBloc>().add(
                      FetchLastTransactionEvent(
                        depositNumber: widget.depositNumber!,
                      ),
                    );
                  },
                );
              }


              if (state.status == SLastTransactionStatus.success) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.topStatement.length,
                  itemExtent: 70,
                  itemBuilder: (context, index) {
                    final item = state.topStatement[index];
                    final amount = item.transferAmount ?? 0;

                    return InkWell(
                      onTap: (){
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
                      child: CustomCard(
                        deposit: item.actionDescription! == 'برداشت' ? false : true,
                        title: state.topStatement[index].actionDescription!,
                        subtitle: item.description ?? '',
                        date: formatPersianDateMD(item.date!.toString()),
                        mount: amount
                            .abs()
                            .toString()
                            .seRagham()
                            .toPersianDigit(),
                      ),
                    );
                  },
                );
              }

              return ErrorRefreshWidget(
                refreshFunction: () {
                  context.read<LastTransactionBloc>().add(
                    FetchLastTransactionEvent(
                      depositNumber: widget.depositNumber!,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
