import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../Core/Routes/transaction_detail_args.dart';
import '../../../Core/Services/check_connection_service.dart';
import '../../../Core/Spacing/app_space.dart';
import '../../../Core/Theme/app_colors.dart';
import '../../../Core/Widgets/no_data_receive.dart';
import '../../Fund_Transfer_Page/Presentation/Bloc/Cart_Tab_Bloc/all_cards_detail_bloc.dart';
import '../../Fund_Transfer_Page/Presentation/Bloc/Cart_Tab_Bloc/all_cards_detail_event.dart';
import '../../Fund_Transfer_Page/Presentation/Bloc/Cart_Tab_Bloc/all_cards_detail_state.dart';
import '../../Fund_Transfer_Page/Presentation/component/Card/custom_drop_down_shimmer.dart';
import 'Bloc/Statement_Bloc/statement_bloc.dart';
import 'Bloc/Statement_Bloc/statement_event.dart';
import 'Bloc/Statement_Bloc/statement_state.dart';
import 'Component/action_icon.dart';
import 'Component/all_transaction_list_widget.dart';
import 'Component/custom_select_date.dart';
import 'Component/jalali_to_utc_iso.dart';
import 'Component/select_transaction_types.dart';
import 'Component/statement_dropdown_button.dart';
import 'Component/statement_list_shimmer.dart';
import 'Component/transaction_info.dart';

enum TransactionType { all, deposit, withdraw }

class StatementPage extends StatefulWidget {
  const StatementPage({super.key});

  @override
  State<StatementPage> createState() => _StatementPageState();
}

class _StatementPageState extends State<StatementPage> {

  String? _selectedDepositNumber;
  bool isFilterActive = false;

  DateTime? _filterStart;
  DateTime? _filterEnd;

  TransactionType selectedType = TransactionType.all;

  void _onOtpChanged(TransactionType value) {
    setState(() {
      selectedType = value;
    });
  }

  final startTimeFormKey = GlobalKey<FormState>();
  final TextEditingController startTimeController = TextEditingController();

  final endTimeFormKey = GlobalKey<FormState>();
  final TextEditingController endTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    checkConnection(context);
    context.read<AllCardsDetailBloc>().add(GetAllCardsDetailEvent());
  }

  void _fetchStatement(String depositNumber) {
    context.read<StatementBloc>().add(
      FetchStatementEvent(depositNumber: depositNumber),
    );
  }

  loadMoreFiltered(selectedType) {
    if (_filterStart != null && _filterEnd != null && _selectedDepositNumber != null) {

      if(selectedType == TransactionType.all){

        context.read<StatementBloc>().add(
          LoadMoreFilteredStatementEvent(
            _selectedDepositNumber!,
            null,
            _filterStart!.toIso8601String(),
            _filterEnd!.toIso8601String(),
          ),
        );
      }else{
        context.read<StatementBloc>().add(
          LoadMoreFilteredStatementEvent(
            _selectedDepositNumber!,
            selectedType == TransactionType.deposit ? 1
                : 0,
            _filterStart!.toIso8601String(),
            _filterEnd!.toIso8601String(),
          ),
        );
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
      body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: isFilterActive
              ? BlocBuilder<StatementBloc, StatementState>(
            builder: (context, state) {
              if (state.status == StatementStateStatus.loading) {
                return StatementListShimmer(itemCount: 15,);
              }

              if (state.status == StatementStateStatus.error) {
                return Center(child: NoDataReceive(description: 'خطا در دریافت تراکنش‌ها'));
              }

              if (state.filteredStatement.isEmpty) {
                return NoDataReceive(description: 'تراکنشی وجود ندارد');
              }

              return ListView.builder(
                itemCount: state.hasMore ? state.filteredStatement.length + 1 : state.filteredStatement.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (index < state.filteredStatement.length) {
                    final item = state.filteredStatement[index];
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
                        height: 70,
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
                            Divider(height: 1, color: Theme
                                .of(context)
                                .dividerColor),
                          ],
                        ),
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
                          loadMoreFiltered(selectedType);
                        },
                        child: Text('مشاهده بیشتر ...',
                          style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .onTertiary
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          )
              : Column(
            children: [
              AppSpace.heightSpace_42,
              _buildHeaderRow(),
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
        Row(
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
                      return Container(
                          height: 380, // 👈 ارتفاع ثابت اینجاست
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(22),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: ListView(
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
                                SelectTransactionTypes(selectedType: selectedType, onCompleted: _onOtpChanged,),

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

                                    if(startTimeFormKey.currentState!.validate() && endTimeFormKey.currentState!.validate()){

                                      final rawStart = jalaliToUtcDate(startTimeController.text);
                                      final rawEnd = jalaliToUtcDate(endTimeController.text);

                                      final startDate = startOfDay(rawStart);
                                      final endDate = endOfDay(rawEnd);

                                      final fixedStart = startDate.isAfter(endDate) ? endDate : startDate;
                                      final fixedEnd   = startDate.isAfter(endDate) ? startDate : endDate;

                                      if(endTimeController.text != '' && startTimeController.text != ''){
                                        context.pop();

                                        selectedType == TransactionType.all
                                            ?
                                        context.read<StatementBloc>().add(
                                          FetchFilterStatementEvent(
                                            depositNumber: _selectedDepositNumber!,
                                            startDate: fixedStart.toIso8601String(),
                                            endDate: fixedEnd.toIso8601String(),
                                          ),
                                        )
                                            :
                                        context.read<StatementBloc>().add(
                                          FetchFilterStatementEvent(
                                            depositNumber: _selectedDepositNumber!,
                                            statementActionType: selectedType == TransactionType.deposit ? 1
                                                : 0,
                                            startDate: fixedStart.toIso8601String(),
                                            endDate: fixedEnd.toIso8601String(),
                                          ),
                                        );

                                        setState(() {
                                          isFilterActive = true;
                                          _filterStart = fixedStart;
                                          _filterEnd = fixedEnd;
                                        });
                                      }
                                    }

                                  },
                                )
                              ],
                            ),
                          )
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
