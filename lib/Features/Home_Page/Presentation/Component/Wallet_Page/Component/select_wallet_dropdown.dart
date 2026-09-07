import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../Core/Theme/app_colors.dart';
import '../../../../../Account_Report_Page/Presentation/Component/dropdown_button.dart';
import '../../../Bloc/Wallet_Bloc/wallet_bloc.dart';
import '../../../Bloc/Wallet_Bloc/wallet_state.dart';

class SelectWalletDropdown extends StatefulWidget {
  const SelectWalletDropdown({super.key, required this.walletList});

  final List<String> walletList;

  @override
  State<SelectWalletDropdown> createState() => _SelectWalletDropdownState();
}

class _SelectWalletDropdownState extends State<SelectWalletDropdown> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.surfaceDim,
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(10, 13, 18, 0.05),
            offset: Offset(0, -2),
            blurRadius: 0,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color.fromRGBO(10, 13, 18, 0.05),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
          BoxShadow(
            color: Color.fromRGBO(10, 13, 18, 0.05),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: BlocBuilder<WalletBloc, WalletState>(
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

              final wallets = state.walletDetails;
              dropdownValue ??= wallets.first.title;

              final List<MenuEntry> menuEntries = wallets.map<MenuEntry>(
                    (wallet) => MenuEntry(value: wallet.title!, label: wallet.title!),
              ).toList();

              return DropdownMenu<String>(
                  width: MediaQuery.of(context).size.width - 83,
                  textAlign: TextAlign.center,
                  trailingIcon: const Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: AppColors.loginPageIconColor,
                    size: 20,
                  ),
                  selectedTrailingIcon: Icon(
                    Icons.keyboard_arrow_up_sharp,
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    size: 20,
                  ),
                  textStyle: TextStyle(color: Theme.of(context).colorScheme.primaryFixed),
                  inputDecorationTheme: InputDecorationTheme(
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    constraints: BoxConstraints.tight(const Size.fromHeight(40)),
                  ),
                  initialSelection: dropdownValue,
                  onSelected: (String? value) {
                    setState(() {
                      dropdownValue = value;
                    });
                  },
                  dropdownMenuEntries: menuEntries
              );
            }
        ),
      ),
    );
  }
}
