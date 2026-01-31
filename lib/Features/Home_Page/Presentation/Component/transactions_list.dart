import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/persian_date_format.dart';
import 'package:neo_bank_mehr_iran/Features/Statment_Page/Presentation/Bloc/Statement_Bloc/statement_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Statment_Page/Presentation/Bloc/Statement_Bloc/statement_state.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../Core/Const/app_space.dart';
import '../../../../Core/Utils/custom_card.dart';

Widget buildTransactionsList(BuildContext context, String? depositNumber) {
  if (depositNumber == null) {
    return const SizedBox(); // یا shimmer
  }

  return Container(
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
          builder: (context, state) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.topStatement.length,
              itemBuilder: (context, index) {
                return CustomCard(
                  deposit: state.topStatement[index].transferAmount! < 0
                      ? false
                      : true,
                  title: state.topStatement[index].transferAmount! < 0
                      ? 'برداشت'
                      : 'واریز',
                  subtitle: state.topStatement[index].description!,
                  date: formatPersianDate(
                    state.topStatement[index].date!.toString(),
                  ),
                  mount: state.topStatement[index].transferAmount!
                      .toString()
                      .seRagham()
                      .toPersianDigit(),
                );
              },
            );
          },
        ),
      ],
    ),
  );
}
