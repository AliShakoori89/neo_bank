import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Fund_Transfer_Page/Presentation/component/Card/custom_drop_down_shimmer.dart';
import '../../../../../Fund_Transfer_Page/Presentation/component/Card/custom_dropdown_button.dart';
import '../../../Bloc/All_cards_Bloc/all_cards_bloc.dart';
import '../../../Bloc/All_cards_Bloc/all_cards_state.dart';

class SelectDepositNumberDropdown extends StatefulWidget {
  const SelectDepositNumberDropdown({super.key, required this.cardDepositNumber});

  final List<String> cardDepositNumber;

  @override
  State<SelectDepositNumberDropdown> createState() => _SelectDepositNumberDropdownState();
}

class _SelectDepositNumberDropdownState extends State<SelectDepositNumberDropdown> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllCardsBloc, AllCardsState>(
      builder: (context, state) {
        final card = state.cards;

        for(int i = 0 ; i < card!.length ; i++){
          widget.cardDepositNumber.add(card[i].depositNumber!);
        }
        if (state.status.isLoading) {
          return CustomDropDownShimmer();
        }
        if (state.status.isSuccess) {
          return CustomDropdownButton(cardsPan: widget.cardDepositNumber, widthSize: double.infinity, heightSize: 55,);
        }
        if (state.status.isError) {
          return Text('کارت بانکی یافت نگردید',style: TextStyle(color: Colors.white),);
        }
        return Text('کارت بانکی یافت نگردید',style: TextStyle(color: Colors.white),);
      },
    );
  }
}
