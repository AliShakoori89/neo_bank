import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';

import '../Charge_Internet_Page/Component/custom_header.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: theme.colorScheme.onPrimaryFixed,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeader(title: 'کیف پول'),
            AppSpace.heightSpace_12,
            Container(
              margin: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('جزئیات موجودی',
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .primaryFixed,
                    ),),
                  AppSpace.heightSpace_8,
                  Text('جزدیات موجودی باقی مانده در کیف پول',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),),
                  AppSpace.heightSpace_128,
                  Center(
                    child: Column(
                      children: [
                        Text('کل موجودی'),
                        AppSpace.heightSpace_16,
                        Text('0'),
                        AppSpace.heightSpace_16,
                        Text('ریال'),
                        AppSpace.heightSpace_32,
                        Container(
                          width: double.infinity,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey.withAlpha(10)
                          ),
                        ),
                        AppSpace.heightSpace_32,
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(30),
                                    topRight: Radius.circular(30)
                                  ),
                                  color: Colors.grey.withAlpha(10)
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 2
                                        )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Icon(Icons.add,
                                        size: 15,
                                        color: AppColors.splashGradiantColor1,),
                                      ),
                                    ),
                                    AppSpace.widthSpace_5,
                                    Text('افزودن موجودی')
                                  ],
                                ),
                              ),
                            ),
                            AppSpace.widthSpace_5,
                            Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(30),
                                      topLeft: Radius.circular(30)
                                  ),
                                  color: Colors.grey.withAlpha(10)
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 2
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Transform.rotate(
                                          angle: 180,
                                          child: Icon(Icons.arrow_back_outlined,
                                            size: 15,
                                            color: AppColors.splashGradiantColor1,),
                                        ),
                                      ),
                                    ),
                                    AppSpace.widthSpace_5,
                                    Text('برداشت / انتقال')
                                  ],
                                ),
                              )
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  AppSpace.heightSpace_16,
                  Divider(
                    color: Colors.grey.withAlpha(10),
                  ),
                  AppSpace.heightSpace_16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('کارت هدیه',
                        style: TextStyle(
                          color: Theme
                              .of(context)
                              .colorScheme
                              .primaryFixed,
                        ),),
                      Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              color: Colors.grey.withAlpha(10)
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.add,
                                  size: 15,
                                  color: AppColors.splashGradiantColor1,),
                                AppSpace.widthSpace_5,
                                Text('افزودن کد هدیه')
                              ],
                            ),
                          )
                      ),
                    ],
                  )
                ],
              ),
            ),
            AppSpace.heightSpace_32,
            Center(child: Icon(Icons.wallet_giftcard_outlined, size: 100, color: Colors.grey.withAlpha(10))),
            AppSpace.heightSpace_32,
            Center(
              child: Text('موجودی کارت های هدیه اینجا نمایش داده میشود',
                style: TextStyle(
                  color: Colors.grey.withAlpha(30)
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
