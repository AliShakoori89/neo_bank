import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/Bloc/Cart_Tab_Bloc/all_cards_detail_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/Bloc/Cart_Tab_Bloc/all_cards_detail_event.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/Bloc/Cart_Tab_Bloc/all_cards_detail_state.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/component/Card/custom_drop_down_shimmer.dart';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Presentation/Bloc/Statement_Bloc/statement_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Presentation/Bloc/Statement_Bloc/statement_event.dart';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Presentation/Component/all_transaction_list_widget.dart';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Presentation/Component/custom_select_date.dart';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Presentation/Component/select_transaction_types.dart';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Presentation/Component/statement_dropdown_button.dart';

enum TransactionType { all, deposit, withdraw }

class StatementPage extends StatefulWidget {
  const StatementPage({super.key});

  @override
  State<StatementPage> createState() => _StatementPageState();
}

class _StatementPageState extends State<StatementPage> {

  String? _selectedDepositNumber;
  bool isFilterActive = false;

  TransactionType selectedType = TransactionType.all;

  final startTimeFormKey = GlobalKey<FormState>();
  final TextEditingController startTimeController = TextEditingController();

  final endTimeFormKey = GlobalKey<FormState>();
  final TextEditingController endTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AllCardsDetailBloc>().add(GetAllCardsDetailEvent());
  }

  void _fetchStatement(String depositNumber) {
    context.read<StatementBloc>().add(
      FetchStatementEvent(depositNumber: depositNumber),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
      body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
          child: isFilterActive
              ? Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .colorScheme
                  .surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'filterSummaryText',
                  style: const TextStyle(fontSize: 12),
                ),
                GestureDetector(
                  onTap: (){},
                  child: const Icon(Icons.close, size: 18),
                )
              ],
            ),
          )
              : Column(
            children: [
              _buildHeaderRow(),
              const SizedBox(height: 12),
              Expanded(
                  child: AllTransactionListWidget(
                      depositNumber: _selectedDepositNumber)),
            ],
          )
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (_) {
                      return DraggableScrollableSheet(
                        expand: false,
                        initialChildSize: 0.4,
                        minChildSize: 0.4,
                        maxChildSize: 0.85,
                        builder: (context, scrollController) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: ListView(
                              controller: scrollController,
                              children: [
                                 Row(
                                   children: [
                                     Text(
                                      'فیلتر تراکنش‌ها',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.primaryFixed,
                                      ),
                                     ),
                                     Spacer(),
                                     IconButton(
                                       icon: Icon(Icons.close),
                                       onPressed: (){
                                         context.pop();
                                       },
                                     )
                                   ],
                                 ),

                                AppSpace.heightSpace_32,
                                SelectTransactionTypes(selectedType: selectedType),

                                AppSpace.heightSpace_32,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('از تاریخ',
                                          style: TextStyle(
                                              color: Theme.of(context).colorScheme.surface,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        AppSpace.heightSpace_12,
                                        CustomDatePicker(
                                          timeFormKey: startTimeFormKey,
                                          timeController: startTimeController,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('تا تاریخ',
                                          style: TextStyle(
                                              color: Theme.of(context).colorScheme.surface,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        AppSpace.heightSpace_12,
                                        CustomDatePicker(
                                          timeFormKey: endTimeFormKey,
                                          timeController: endTimeController,
                                        ),
                                      ],
                                    )

                                  ],
                                ),

                                AppSpace.heightSpace_32,
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.splashGradiantColor1,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Color.fromRGBO(255, 255, 255, 0.12),
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                    ),
                                  ),
                                  child: Text('تایید',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  onPressed: (){

                                    print(startTimeController.text);

                                    if(startTimeFormKey.currentState!.validate() && endTimeFormKey.currentState!.validate()){
                                      if(endTimeController.text != '' && startTimeController.text != ''){
                                        context.pop();
                                        // context.read<StatementBloc>().add(
                                        //   FetchFilterStatementEvent(
                                        //     depositNumber: _selectedDepositNumber!,
                                        //     statementActionType: selectedType == TransactionType.deposit ? 0
                                        //         : selectedType == TransactionType.withdraw ? 1 : null,
                                        //     startDate: ,
                                        //     endDate:
                                        //   ),
                                        // );
                                      }
                                    }

                                  },
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),

              IconButton(
                icon: Icon(Icons.download_outlined),
                onPressed: (){

                },
              )
            ]
          ),
        ),

        /// 🔽 Dropdown کارت‌ها
        Align(
          alignment: Alignment.topCenter,
          child: BlocListener<AllCardsDetailBloc, AllCardsDetailState>(
            listener: (context, state) {
              if (state.status.isSuccess &&
                  state.cardsDeposit != null &&
                  state.cardsDeposit!.isNotEmpty &&
                  _selectedDepositNumber == null) {
                final firstCard = state.cardsDeposit!.first;

                setState(() => _selectedDepositNumber = firstCard);
                _fetchStatement(firstCard);
              }
            },
            child: BlocBuilder<AllCardsDetailBloc, AllCardsDetailState>(
              builder: (context, state) {
                if (state.status.isLoading) {
                  return const CustomDropDownShimmer();
                }

                if (state.status.isError) {
                  return const Text('خطا در لود کارت‌ها');
                }

                final cards = state.cardsDeposit;

                if (cards == null || cards.isEmpty) {
                  return const Text('کارت موجود نیست');
                }

                return StatementDropdownButton(
                  cardsDeposit: cards,
                  selectedValue: _selectedDepositNumber ?? cards.first,
                  onChanged: (value) {
                    setState(() => _selectedDepositNumber = value);
                    _fetchStatement(value);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
