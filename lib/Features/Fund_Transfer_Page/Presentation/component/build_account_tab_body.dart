import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../Bloc/Account_Tab_Bloc/user_all_account_bloc.dart';
import '../Bloc/Account_Tab_Bloc/user_all_account_state.dart';

Widget buildAccountTabBody(BuildContext context) {
  final theme = Theme.of(context);

  Widget buildRow(String title, Widget value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100, // عرض ثابت برای ستون عنوان
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Align(alignment: Alignment.centerRight, child: value),
          ),
        ],
      ),
    );
  }

  return BlocBuilder<UserAllAccountBloc, UserAllAccountState>(
    builder: (context, state) {

      return state.allAccount != null
          ? ListView.builder(
              itemCount: state.allAccount!.length,
              itemBuilder: (context, index) {
                final item = state.allAccount![index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: theme.tabBarTheme.indicatorColor,
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        buildRow(
                          'شماره حساب:',
                          Text(item.depositNumber.toString().toPersianDigit()),
                        ),
                        buildRow(
                          'موجودی:',
                          Text(
                            item.availableBalance
                                .toString()
                                .toPersianDigit()
                                .seRagham(),
                          ),
                        ),
                        buildRow(
                          'نوع حساب:',
                          Text(
                            item.depositTitle.toString(),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        buildRow(
                          'شماره شبا:',
                          Text(item.ibanNumber.toString()),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(child: Text('موردی برای نمایش یافت نگردید.'));
    },
  );
}
