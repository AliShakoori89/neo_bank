import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/persian_date_format_M_D.dart';
import 'package:neo_bank_mehr_iran/Features/Statment_Page/Presentation/Bloc/Statement_Bloc/statement_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Statment_Page/Presentation/Bloc/Statement_Bloc/statement_state.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../../Core/Const/app_space.dart';
import '../../../../../Core/Utils/custom_card.dart';

Widget buildTransactionsListWidget(
  BuildContext context,
  String? depositNumber,
) {
  if (depositNumber == null) {
    return const SizedBox(); // یا shimmer
  }

  return InkWell(
    onTap: () {
      context.push('/statement_page');
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12, right: 25, bottom: 10),
            child: Text(
              'آخرین تراکنش‌ها',
              style: TextStyle(
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          AppSpace.heightSpace_24,
          BlocBuilder<StatementBloc, StatementState>(
            buildWhen: (prev, curr) =>
                prev.topStatement != curr.topStatement ||
                prev.status != curr.status,
            builder: (context, state) {
              if (state.status == StatementStateStatus.loading &&
                  state.topStatement.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.status == StatementStateStatus.error) {
                return Text(
                  'خطا در دریافت تراکنش‌ها',
                  style: TextStyle(color: Colors.red),
                );
              }

              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.topStatement.length,
                itemBuilder: (context, index) {
                  final item = state.topStatement[index];
                  final amount = item.transferAmount ?? 0;

                  return CustomCard(
                    deposit: amount >= 0,
                    title: state.topStatement[index].actionDescription!,
                    subtitle: item.description ?? '',
                    date: formatPersianDateMD(item.date!.toString()),
                    mount: amount.abs().toString().seRagham().toPersianDigit(),
                  );
                },
              );
            },
          ),
        ],
      ),
    ),
  );
}
