import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Statement_Page/Presentation/Component/custom_drop_down_shimmer.dart';
import '../Bloc/Cart_Tab_Bloc/all_cards_detail_bloc.dart';
import '../Bloc/Cart_Tab_Bloc/all_cards_detail_event.dart';
import '../Bloc/Cart_Tab_Bloc/all_cards_detail_state.dart';
import 'Card/custom_dropdown_button.dart';

class BankCardSelector extends StatefulWidget {
  const BankCardSelector({super.key, this.widthSize, this.heightSize});

  final double? widthSize;
  final double? heightSize;

  @override
  State<BankCardSelector> createState() => _BankCardSelectorState();
}

class _BankCardSelectorState extends State<BankCardSelector> {

  @override
  void initState() {
    BlocProvider.of<AllCardsDetailBloc>(context).add(GetAllCardsDetailEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllCardsDetailBloc, AllCardsDetailState>(
      builder: (context, state) {
        final cardsPan = state.cardsPan;
        if (state.status.isLoading) {
          return CustomDropDownShimmer();
        }
        if (state.status.isSuccess) {
          return CustomDropdownButton(cardsPan: cardsPan!, widthSize: widget.widthSize, heightSize: widget.heightSize,);
        }
        if (state.status.isError) {
          return Text('کارت بانکی یافت نگردید',style: TextStyle(color: Colors.white),);
        }
        return Text('کارت بانکی یافت نگردید',style: TextStyle(color: Colors.white),);
      },
    );
  }
}
