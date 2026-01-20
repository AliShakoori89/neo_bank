import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/Bloc/Account_Tab_Bloc/user_all_account_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/Bloc/Account_Tab_Bloc/user_all_account_state.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

Widget buildAccountTabBody(BuildContext context) {
  final theme = Theme.of(context);

  return BlocBuilder<UserAllAccountBloc, UserAllAccountState>(
    builder: (context, state) {
      return state.allAccount != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: theme.tabBarTheme.indicatorColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: 15,
                        bottom: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('شماره حساب : '),
                              AppSpace.heightSpace_4,
                              Text('موجودی : '),
                              AppSpace.heightSpace_4,
                              Text('نوع حساب : '),
                              AppSpace.heightSpace_4,
                              Text('شماره شبا : '),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                state.allAccount!.data![index].depositNumber
                                    .toString()
                                    .toPersianDigit(),
                              ),
                              AppSpace.heightSpace_4,
                              Text(
                                state.allAccount!.data![index].availableBalance
                                    .toString()
                                    .toPersianDigit()
                                    .seRagham(),
                              ),
                              AppSpace.heightSpace_4,
                              Text(
                                state.allAccount!.data![index].depositTitle
                                    .toString(),
                              ),
                              AppSpace.heightSpace_4,
                              Text(
                                state.allAccount!.data![index].ibanNumber
                                    .toString(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: state.allAccount != null
                  ? state.allAccount!.data != null
                        ? state.allAccount!.data!.length
                        : 0
                  : 0,
            )
          : Center(child: Text('موردی برای نمایش یافت نگردید.'));
    },
  );
}
