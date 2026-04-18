import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/custom_linear_gradient.dart';
import '../../../../../../../Core/Const/app_space.dart';
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
    {'id' : 8 ,'itemName': 'بیشتر', 'icon': Icons.more_horiz},
  ];

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.55,
        minChildSize: 0.55,
        maxChildSize: 0.85,
        builder: (context, scrollController) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              controller: scrollController,
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
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: (){
                        context.pop();
                      },
                    )
                  ],
                ),
                AppSpace.heightSpace_32,
                GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // تعداد ستون‌ها در هر سطر
                      crossAxisSpacing: 30.0, // فاصله افقی بین آیتم‌ها
                      mainAxisSpacing: 30.0, // فاصله عمودی بین آیتم‌ها
                      childAspectRatio: 3.0, // نسبت عرض به ارتفاع هر آیتم (1.0 یعنی مربع)
                    ),
                    shrinkWrap: true,
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index){
                      return InkWell(
                        child: Container(
                          width: 50,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: customLinearGradient(context),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                detailsItem[index]['icon'],
                                color: Theme.of(context).colorScheme.surfaceBright,
                              ),
                              AppSpace.widthSpace_8,
                              Text(detailsItem[index]['itemName'],
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surfaceBright,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: (){
                          if(detailsItem[index]['id'] == 1){
                            copyAndShare(context, cardPan, cardDeposit);
                          }
                        },
                      );


                    })
              ],
            ),
          );
        },
      );
    },
  );
}