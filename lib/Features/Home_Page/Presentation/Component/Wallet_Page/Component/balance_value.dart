import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../../../Core/Utils/error_refresh_widget.dart';
import '../../../Bloc/Wallet_Bloc/wallet_bloc.dart';
import '../../../Bloc/Wallet_Bloc/wallet_event.dart';
import '../../../Bloc/Wallet_Bloc/wallet_state.dart';

class BalanceValue extends StatelessWidget {
  const BalanceValue({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return SizedBox(
              width: 25,
              height: 25,
              child: const CircularProgressIndicator());
        } else if (state.status.isSuccess) {
          if (state.walletDetails != null && state.walletDetails!.isNotEmpty) {
            return Text(state.walletDetails!.first.balance.toString().toPersianDigit().seRagham(),
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18
              ),
            );
          } else {
            return const Text('کیف پولی یافت نشد');
          }
        } else if (state.status.isError) {
          return ErrorRefreshWidget(
            title: '',
            heightSize: 50,
            refreshFunction: () {
              context.read<WalletBloc>().add(WalletDetailsPackages());
            },
          );
        }
        return ErrorRefreshWidget(
          title: '',
          heightSize: 50,
          refreshFunction: () {
            context.read<WalletBloc>().add(WalletDetailsPackages());
          },
        );
      },
    );
  }
}
