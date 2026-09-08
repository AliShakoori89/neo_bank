import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../../../Core/Spacing/app_space.dart';
import '../../../../Domain/Entities/wallet_entity.dart';
import '../../../Bloc/Wallet_Bloc/wallet_bloc.dart';
import '../../../Bloc/Wallet_Bloc/wallet_state.dart';

class WalletTypesList extends StatelessWidget {
  const WalletTypesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator()));
        }

        if (state.status.isError) {
          return const Center(child: Text('خطایی رخ داده است'));
        }

        if (state.walletDetails.isEmpty) {
          return const Center(child: Text('کیف پولی در دسترس نیست!'));
        }

        final List<WalletEntity> displayWallets = List.from(state.walletDetails);

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: displayWallets.length,
          itemBuilder: (context, index) {
            return state.walletDetails[index].title == 'عادی'
                ? Container()
                : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withAlpha(30),
                ),
                child: Container(
                  margin: EdgeInsets.only(
                      top: 10,
                      right: 10
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.walletDetails[index].title!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primaryFixed,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            state.walletDetails[index].balance.toString().seRagham().toPersianDigit(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primaryFixed,
                            ),
                          ),
                          AppSpace.widthSpace_8,
                          Text(
                            'ریال',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primaryFixed,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
