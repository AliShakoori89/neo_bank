import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../Core/Spacing/app_space.dart';
import '../../../../../../Core/Widgets/custom_refresh_button.dart';
import '../../../Bloc/Wallet_Bloc/wallet_bloc.dart';
import '../../../Bloc/Wallet_Bloc/wallet_event.dart';
import 'balance_value.dart';

class AllBalanceWidget extends StatelessWidget {
  const AllBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.withAlpha(25),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('کل موجودی',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryFixed,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),),
                RefreshButtonWithAnimation(
                  onPressed: () async {
                    context.read<WalletBloc>().add(WalletDetailsPackagesEvent());
                  },
                  color: Theme.of(context).colorScheme.primaryFixed,
                  size: 24,
                )

              ],
            ),
            AppSpace.heightSpace_16,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BalanceValue(),
                AppSpace.widthSpace_5,
                Text('تومان',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryFixed,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),),
              ],
            ),
            AppSpace.heightSpace_48, // کاهش از 32 به 24
          ],
        ),
      ),
    );
  }
}
