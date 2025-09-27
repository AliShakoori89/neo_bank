import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Core/Const/stack_circle.dart';

import '../../Core/Const/app_colors.dart';
import '../../Core/Const/app_space.dart';
import 'Presentation/Component/inward_curve_clipper.dart';
import 'Presentation/Component/slider_image.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {

    List<Map<String, String>> icons = [
      {'icon': 'assets/icon/sim-card.png', 'title': 'شارژ'},
      {'icon': 'assets/icon/worldwide.png', 'title': 'اینترنت'},
      {'icon': 'assets/icon/bill.png', 'title': 'قبض'},
      {'icon': 'assets/icon/money-back.png', 'title': 'برگشت پول'},
      {'icon': 'assets/icon/vam.png', 'title': 'وام'},
      {'icon': 'assets/icon/money.png', 'title': 'برداشت خودکار'},
      {'icon': 'assets/icon/share.png', 'title': 'دنگ'},
      {'icon': 'assets/icon/cheque.png', 'title': 'چک برگشتی'},
      {'icon': 'assets/icon/automobile_service.png', 'title': 'خدمات خودرو'},
      {'icon': 'assets/icon/increase.png', 'title': 'دعوت دوستان'},
    ];

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ClipPath(
                    clipper: InwardCurveClipper(),
                    child: Stack(
                      children: [
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          color: AppColors.primaryColor,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 20,
                                right: 20
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('assets/Logo/qbank.png',
                                          ),
                                          colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn)
                                      )
                                  ),
                                ),
                                Spacer(),
                                SizedBox(
                                    height: 70,
                                    child: Icon(Icons.support_agent_outlined,
                                      color: Colors.black,)
                                ),
                              ],
                            ),
                          ),
                        ),
                        StackCircle(
                          width: 200,
                          height: 200,
                          topPosition: -50,
                          leftPosition: -100,
                        ),
                        StackCircle(
                          width: 50,
                          height: 50,
                          leftPosition: 100,
                        ),
                        StackCircle(
                          width: 20,
                          height: 20,
                          leftPosition: 150,
                        ),
                      ],
                    ),
                  ),
                ),
                AppSpace.heightSpace_128,
                Container(
                  height: 450,
                  margin: EdgeInsets.only(
                      left: 20,
                      right: 20
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(top: 10),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 111 / 170,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 40,
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(30),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        margin: EdgeInsets.all(1),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: 10
                              ),
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(icons[index]['icon']!)
                                  )
                              ),
                            ),
                            AppSpace.heightSpace_8,
                            Text(icons[index]['title']!,
                              overflow: TextOverflow.ellipsis,
                              textDirection: TextDirection.rtl,
                              style: Theme.of(context).textTheme.bodyLarge
                            )
                          ],
                        ),
                      );
                    },),
                )
              ],
            ),
            Positioned(
                top: 100,
                left: 30,
                right: 30, // با این دو خط وسط میاد
                child: AdvertisementSliderImage()
            )
          ],
        ),
      ),
    );
  }
}
