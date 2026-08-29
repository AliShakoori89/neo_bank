import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../../Core/Spacing/app_space.dart';
import 'Component/Copy_And_Share/copy_and_share.dart';

bankCardDetails(context, String cardPan, String cardDeposit){

  List<Map> detailsItem = [
    {'id' : 1 ,'itemName': 'کپی و اشتراک', 'icon': Icons.share},
    {'id' : 2 ,'itemName': 'تراکنش ها', 'icon': Icons.cached},
    {'id' : 3 ,'itemName': 'تغییر رمز اول', 'icon': Icons.change_circle},
    {'id' : 4 ,'itemName': 'صدور رمز اول', 'icon': Icons.key},
    {'id' : 5 ,'itemName': 'تعیین رمز دوم', 'icon': Icons.key_sharp},
    {'id' : 6 ,'itemName': 'مسدود کردن', 'icon': Icons.block},
    {'id' : 7 ,'itemName': 'غیر فعال سازی رمز دوم', 'icon': Icons.key_off},
    // {'id' : 8 ,'itemName': 'بیشتر', 'icon': Icons.more_horiz},
  ];

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      {
        return Container(
          height: 450, // 👈 ارتفاع ثابت اینجاست
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(22),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'جزئیات کارت',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primaryFixed,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),

                AppSpace.heightSpace_16,

                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15.0,
                      childAspectRatio: 3,
                    ),
                    itemCount: detailsItem.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          final id = detailsItem[index]['id'];
                          if (id == 1) {
                            copyAndShare(context, cardPan, cardDeposit);
                          } else if (id == 2) {
                            context.push('/statement_page');
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Spacer(),
                                Expanded(
                                  flex: 1,
                                  child: Icon(
                                    detailsItem[index]['icon'],
                                    color: Theme.of(context).colorScheme.surfaceBright,
                                    size: 20,
                                  ),
                                ),
                                AppSpace.widthSpace_5,
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    detailsItem[index]['itemName'],
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.surfaceBright,
                                      fontWeight: FontWeight.w100,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      }
    },
  );
}