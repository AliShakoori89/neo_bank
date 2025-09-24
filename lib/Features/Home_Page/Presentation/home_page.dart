import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Core/Const/stack_circle.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/custom_card.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../Menu_Page/Presentation/Component/inward_curve_clipper.dart';
import '../../Menu_Page/Presentation/Component/slider_image.dart';
import 'Component/custom_icon.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                    onPressed: (){

                                    },
                                    icon: Icon(Icons.search,
                                      color: Colors.black,
                                    )
                                ),
                                IconButton(
                                    onPressed: (){

                                    },
                                    icon: Icon(Icons.add_chart_outlined,
                                      color: Colors.black,)
                                ),
                              ],
                            ),
                            Spacer(),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: (){

                                    },
                                    icon: Icon(Icons.add_alert_outlined,
                                      color: Colors.black,)
                                ),
                                IconButton(
                                    onPressed: (){

                                    },
                                    icon: Icon(Icons.help_outline,
                                      color: Colors.black,)
                                ),
                              ],
                            ),
                          ],
                        ),
                        AppSpace.heightSpace_64,
                        Text('${'479,550'.toPersianDigit()} ریال',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24
                            )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: (){

                                },
                                icon: Icon(Icons.remove_red_eye,
                                  color: Colors.black,)
                            ),
                            Text('موجودی',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14
                                )),
                            IconButton(
                                onPressed: (){

                                },
                                icon: Icon(Icons.keyboard_arrow_down,
                                  color: Colors.black,)
                            ),
                          ],
                        ),
                        AppSpace.heightSpace_24,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).scaffoldBackgroundColor.withAlpha(200),
                                      shape: BoxShape.circle
                                  ),
                                  child: IconButton(
                                      onPressed: (){
                                      }, icon: Icon(Icons.add)),
                                ),
                                Text("شارژ حساب",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold
                                ))
                              ],
                            ),
                            AppSpace.widthSpace_18,
                            CustomIcon(
                              title: "باکس",
                              iconData: Icons.gif_box_outlined,
                            ),
                            AppSpace.widthSpace_18,
                            CustomIcon(
                              title:"گزارش مالی",
                              iconData: Icons.report,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  StackCircle(
                    topPosition: -50,
                    rightPosition: -150,
                    height: 300,
                    width: 300
                  ),
                  StackCircle(
                      topPosition: -50,
                      leftPosition: -100,
                      height: 250,
                      width: 250
                  ),
                  StackCircle(
                    topPosition: 150,
                    leftPosition: 120,
                    width: 100,
                    height: 100),
                  StackCircle(
                    leftPosition: 220,
                    topPosition: 250,
                    width: 50,
                    height: 50,
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 10,
                  ),
                  child: ListView.builder(
                    itemCount: 2,
                    itemExtent: 70,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: 10
                        ),
                        child: CustomCard(
                            iconData: Icons.compare_arrows,
                            title: 'انتقال پایا',
                            widget1: Row(
                              children: [
                                Text('یکشنبه، ',
                                  style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold
                                  ),),
                                Text('14'.toPersianDigit(),
                                  style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold
                                  ),),
                                AppSpace.widthSpace_5,
                                Text('مرداد',
                                  style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold
                                  ),),
                                AppSpace.widthSpace_5,
                                Text('1404  21:47'.toPersianDigit(),
                                  style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold
                                  ),),
                              ],
                            ),
                            widget2: Row(
                              children: [
                                Text('205000000'.seRagham().toPersianDigit(),
                                  style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                AppSpace.widthSpace_5,
                                Text('ریال'.seRagham().toPersianDigit(),
                                  style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            )),
                      );
                    },
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
