import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Fund_Transfer_Page/Presentation/component/Card/custom_drop_down_shimmer.dart';
import '../../../../../Fund_Transfer_Page/Presentation/component/Card/custom_dropdown_button.dart';
import '../../../Bloc/All_cards_Bloc/all_cards_bloc.dart';
import '../../../Bloc/All_cards_Bloc/all_cards_state.dart';

class SelectDepositNumberDropdown extends StatefulWidget {
  const SelectDepositNumberDropdown({super.key, required this.onSelected});

  final Function(String) onSelected; // ✅ اضافه کردن callback

  @override
  State<SelectDepositNumberDropdown> createState() => _SelectDepositNumberDropdownState();
}

class _SelectDepositNumberDropdownState extends State<SelectDepositNumberDropdown> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllCardsBloc, AllCardsState>(
      builder: (context, state) {
        final card = state.cards;

        if (state.status.isLoading) {
          return const CustomDropDownShimmer();
        }

        if (state.status.isSuccess && card != null && card.isNotEmpty) {
          final cardDepositNumbers = card.map((c) => c.depositNumber!).toList();

          // اگر مقدار انتخاب شده قبلی null است، اولین مقدار را انتخاب کن
          if (_selectedValue == null && cardDepositNumbers.isNotEmpty) {
            _selectedValue = cardDepositNumbers.first;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.onSelected(_selectedValue!);
            });
          }

          return CustomDropdownButton(
            cardsPan: cardDepositNumbers,
            widthSize: double.infinity,
            heightSize: 55,
            onChanged: (value) {  // ✅ اضافه کردن onChanged به CustomDropdownButton
              setState(() {
                _selectedValue = value;
              });
              widget.onSelected(value);
            },
          );
        }

        if (state.status.isError) {
          return Text('کارت بانکی یافت نگردید', style: TextStyle(color: Colors.white));
        }

        return Text('کارت بانکی یافت نگردید', style: TextStyle(color: Colors.white));
      },
    );
  }
}