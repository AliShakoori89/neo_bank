import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank/Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/Internet_package/Package_Card_Component/Package_Details/Component/payment_types_card.dart';
import '../../../../../../../../Data/Model/wallet_model.dart';
import '../../../../../../../Bloc/Wallet_Bloc/wallet_bloc.dart';
import '../../../../../../../Bloc/Wallet_Bloc/wallet_state.dart';

class PayTypesList extends StatefulWidget {
  const PayTypesList({
    super.key,
    required this.theme,
    required this.selectedCardIndex,
    required this.onWalletSelected,
  });

  final ThemeData theme;
  final int selectedCardIndex;
  final Function(int index, String address, String title) onWalletSelected;

  @override
  State<PayTypesList> createState() => _PayTypesListState();
}

class _PayTypesListState extends State<PayTypesList> {
  late int localSelectedIndex;

  @override
  void initState() {
    super.initState();
    localSelectedIndex = widget.selectedCardIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status.isError) {
          return const Center(child: Text('خطایی رخ داده است'));
        }

        if (state.walletDetails.isEmpty) {
          return const Center(child: Text('کیف پولی در دسترس نیست!'));
        }

        final List<WalletModel> displayWallets =
        List.from(state.walletDetails);

        return ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: displayWallets.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: PaymentTypesCard(
                title: displayWallets[index].title!,
                description:
                'موجودی: ${displayWallets[index].balance} تومان',
                isSelected: localSelectedIndex == index,
                onTap: () {
                  setState(() {
                    localSelectedIndex = index;
                  });
                  widget.onWalletSelected(
                    index,
                    displayWallets[index].address!,
                    displayWallets[index].title!,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}