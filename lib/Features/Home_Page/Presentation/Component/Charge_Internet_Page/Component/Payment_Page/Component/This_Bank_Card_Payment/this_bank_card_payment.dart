import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../../Core/Widgets/error_refresh_widget.dart';
import '../../../../../../../../Fund_Transfer_Page/Presentation/Bloc/Account_Tab_Bloc/user_all_account_bloc.dart';
import '../../../../../../../../Fund_Transfer_Page/Presentation/Bloc/Account_Tab_Bloc/user_all_account_event.dart';
import '../../../../../../../Data/Model/card_list_model.dart';
import '../../../../../../Bloc/All_cards_Bloc/all_cards_bloc.dart';
import '../../../../../../Bloc/All_cards_Bloc/all_cards_state.dart';
import '../../../../../Wallet_Page/Component/custom_selector_card.dart';

class ThisBankCardPayment extends StatefulWidget {
  const ThisBankCardPayment({super.key});

  @override
  State<ThisBankCardPayment> createState() => _ThisBankCardPaymentState();
}

class _ThisBankCardPaymentState extends State<ThisBankCardPayment> {

  var selectedCardIndex = 0;

  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();
    BlocProvider.of<UserAllAccountBloc>(context).add(GetUserAllAccountEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<AllCardsBloc, AllCardsState>(
              builder: (context, state) {
                if (state.status.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
        
                else if (state.status.isError) {
                  return const Center(child: Text('خطایی رخ داده است'));
                }
                
                else if(state.status.isSuccess){
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.cards!.length,
                    itemBuilder: (context, index) {
        
                      CardDataModel card = CardDataModel(
                        availableBalance: state.cards![index].availableBalance,
                        cardDeposit: state.cards![index].cardDeposit,
                        depositNumber: state.cards![index].depositNumber,
                        expireDate: state.cards![index].expireDate,
                        pan: state.cards![index].pan
                      );
        
                      return Padding(
                        padding: EdgeInsetsGeometry.only(
                            bottom: 15,
                            top: 5
                        ),
                        child: CustomSelectorCard(
                          theme: theme,
                          bankCard: card,
                          isSelected: selectedCardIndex == index,
                          onTap: () {
                            setState(() {
                              selectedCardIndex = index;
                            });
                          },
                        ),
                      );
                    },
                  );
        
                } 
                return ErrorRefreshWidget(
                  refreshFunction: () {
                    BlocProvider.of<UserAllAccountBloc>(context).add(GetUserAllAccountEvent());
                  },
                );
        
              },
            )
          ],
        ),
      ),
    );
  }
}
