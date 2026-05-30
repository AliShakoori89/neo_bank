import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../Bloc/Wallet_Bloc/wallet_bloc.dart';
import '../../../Bloc/Wallet_Bloc/wallet_state.dart';

class BalanceValue extends StatelessWidget {
  const BalanceValue({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return Container();
        } else if (state.status.isSuccess) {
          if (state.walletDetails.isNotEmpty) {
            return Text(state.walletDetails.first.balance.toString().toPersianDigit().seRagham(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.primaryFixed,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            );
          } else {
            return const Text('کیف پولی یافت نشد');
          }
        } else if (state.status.isError) {
          return Text('-');
        }
        return Text('-');
      },
    );
  }
}
