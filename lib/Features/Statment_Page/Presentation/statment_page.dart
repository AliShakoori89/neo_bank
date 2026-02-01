import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/Bloc/Cart_Tab_Bloc/all_cards_detail_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/Bloc/Cart_Tab_Bloc/all_cards_detail_event.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/Bloc/Cart_Tab_Bloc/all_cards_detail_state.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/component/Card/custom_drop_down_shimmer.dart';
import 'package:neo_bank_mehr_iran/Features/Statment_Page/Presentation/Bloc/Statement_Bloc/statement_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Statment_Page/Presentation/Bloc/Statement_Bloc/statement_event.dart';
import 'package:neo_bank_mehr_iran/Features/Statment_Page/Presentation/Component/all_transaction_list_widget.dart';
import 'package:neo_bank_mehr_iran/Features/Statment_Page/Presentation/Component/custom_dropdown_button.dart';

class StatmentPage extends StatefulWidget {
  const StatmentPage({super.key});

  @override
  State<StatmentPage> createState() => _StatmentPageState();
}

class _StatmentPageState extends State<StatmentPage> {
  String? _selectedDepositNumber;

  @override
  void initState() {
    super.initState();
    context.read<AllCardsDetailBloc>().add(GetAllCardsDetailEvent());
  }

  void _fetchStatement(String depositNumber, int count) {
    context.read<StatementBloc>().add(
      FetchStatementEvent(depositNumber: depositNumber, latestCount: count),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
        child: Column(
          children: [
            _buildHeaderRow(),
            const SizedBox(height: 12),
            AllTransactionListWidget(depositNumber: _selectedDepositNumber),
          ],
        ),
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
            children: [const Icon(Icons.search), Icon(Icons.download_outlined)],
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
                _fetchStatement(firstCard, state.cardsDeposit!.length);
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

                return CustomDropdownButton(
                  cardsDeposit: cards,
                  selectedValue: _selectedDepositNumber ?? cards.first,
                  onChanged: (value) {
                    setState(() => _selectedDepositNumber = value);
                    _fetchStatement(value, cards.length);
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
