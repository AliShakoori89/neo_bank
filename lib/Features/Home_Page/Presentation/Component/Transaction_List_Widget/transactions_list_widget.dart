import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/persian_date_format_M_D.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Last_Transaction_Bloc/last_transaction_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Last_Transaction_Bloc/last_transaction_event.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Last_Transaction_Bloc/last_transaction_state.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../../Core/Const/app_space.dart';
import '../../../../../Core/Utils/custom_card.dart';

class TransactionsListWidget extends StatefulWidget {
  const TransactionsListWidget({super.key, required this.depositNumber});

  final String? depositNumber;

  @override
  State<TransactionsListWidget> createState() => _TransactionsListWidgetState();
}

class _TransactionsListWidgetState extends State<TransactionsListWidget> {

  @override
  void initState() {
    BlocProvider.of<LastTransactionBloc>(context).add(
      FetchLastTransactionEvent(
        depositNumber: widget.depositNumber!),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.depositNumber == null) {
      return const SizedBox(); // یا shimmer
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 0, right: 25, bottom: 10),
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
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.primaryFixed,
                      size: 16,
                    ),
                    onPressed: (){
                      context.push('/statement_page');
                    },
                  ),
                ],
              ),
            ),
          ),
          AppSpace.heightSpace_24,
          BlocBuilder<LastTransactionBloc, LastTransactionState>(
            // buildWhen: (prev, curr) =>
            //     prev.topStatement != curr.topStatement ||
            //     prev.status != curr.status,
            builder: (context, state) {
              if (state.status == SLastTransactionStatus.loading &&
                  state.topStatement.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.status == SLastTransactionStatus.error) {
                return Center(
                  child: Padding(
                    padding: EdgeInsetsGeometry.only(
                        top: 40
                    ),
                    child: Text(
                      'خطا در دریافت تراکنش‌ها !',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }

              if (state.status == SLastTransactionStatus.success) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.topStatement.length,
                  itemBuilder: (context, index) {
                    final item = state.topStatement[index];
                    final amount = item.transferAmount ?? 0;

                    return CustomCard(
                      deposit: item.actionDescription! == 'برداشت' ? false : true,
                      title: state.topStatement[index].actionDescription!,
                      subtitle: item.description ?? '',
                      date: formatPersianDateMD(item.date!.toString()),
                      mount: amount
                          .abs()
                          .toString()
                          .seRagham()
                          .toPersianDigit(),
                    );
                  },
                );
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }
}
