import 'package:flutter/material.dart';
import 'package:neo_bank/Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/Internet_package/Package_Card_Component/Package_Details/Component/pay_types_list.dart';

import '../../../../../../../../../../Core/Widgets/custom_button.dart';
import '../../../../../../../../../../Core/Widgets/custom_disable_button.dart';

class WalletSelector {
  static Future<Map<String, String>?> selectWallet({
    required BuildContext context,
    required int currentSelectedIndex,
  }) async {
    int selectedCardIndex = currentSelectedIndex;
    String? selectedWalletAddress;
    String? selectedWalletTitle;

    return await showModalBottomSheet<Map<String, String>>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          maxChildSize: 0.7,
          minChildSize: 0.3,
          expand: false,
          builder: (context, scrollController) {
            return StatefulBuilder(
              builder: (context, setStateSheet) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            'انتخاب کیف پول',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryFixed,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      const Divider(),
                      Expanded(
                        child: PayTypesList(
                          theme: Theme.of(context),
                          selectedCardIndex: selectedCardIndex,
                          onWalletSelected: (index, address, title) {
                            setStateSheet(() {
                              selectedCardIndex = index;
                              selectedWalletAddress = address;
                              selectedWalletTitle = title;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      selectedCardIndex != -1
                          ? CustomButton(
                        buttonTitle: 'تایید',
                        buttonOnPressed: () {
                          Navigator.pop(context, {
                            'address': selectedWalletAddress!,
                            'title': selectedWalletTitle!,
                          });
                        },
                      )
                          : const CustomDisableButton(),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}