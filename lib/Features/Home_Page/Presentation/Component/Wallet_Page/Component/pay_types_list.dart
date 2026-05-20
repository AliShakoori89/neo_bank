import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Data/Model/wallet_model.dart';
import '../../../Bloc/Wallet_Bloc/wallet_bloc.dart';
import '../../../Bloc/Wallet_Bloc/wallet_state.dart';
import 'custom_card.dart';

class PayTypesList extends StatefulWidget {
  PayTypesList({super.key, required this.theme, required this.selectedCardIndex});

  final ThemeData theme;
  late int selectedCardIndex;

  @override
  State<PayTypesList> createState() => _PayTypesListState();
}

class _PayTypesListState extends State<PayTypesList> {
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

        if (state.walletDetails?.isEmpty ?? true) {
          return const Center(child: Text('کیف پولی در دسترس نیست!'));
        }

        // ایجاد یک لیست جدید شامل کیف پول‌های موجود + گزینه پرداخت اینترنتی
        final List<WalletModel> displayWallets = List.from(state.walletDetails!);

        // اضافه کردن گزینه پرداخت اینترنتی
        displayWallets.add(WalletModel(
          address: "",
          title: "پرداخت اینترنتی",
          walletType: (state.walletDetails!.last.walletType + 1),
          isActive: true,
          balance: 0,
        ));

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: displayWallets.length,
          itemBuilder: (context, index) {
            return CustomCard(
              theme: widget.theme,
              title: displayWallets[index].title,
              isSelected: widget.selectedCardIndex == index,
              onTap: () {
                setState(() {
                  widget.selectedCardIndex = index;
                });
              },
            );
          },
        );
      },
    );
  }
}
