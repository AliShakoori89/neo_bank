import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Core/Const/app_colors.dart';
import '../../../../Core/Const/app_space.dart';

Widget buildCartTabBody(BuildContext context){
  return Column(
    children: [

      AppSpace.heightSpace_24,

      // --- مبلغ انتقال ---

      Form(
          child: Container(
            margin: EdgeInsets.only(right: 30, left: 30),
            height: 50,
            color: Theme.of(context).colorScheme.outline,
            child: TextFormField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  suffixText: 'ریال',
                  suffixStyle: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF181D27)
                  ),
                  hintText: 'مبلغ انتقال',
                  hintStyle: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.surface,
                  ),
                  border: OutlineInputBorder(borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surfaceDim
                  )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.surfaceDim
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue
                      )
                  )
              ),
            ),
          )),
      AppSpace.heightSpace_24,

      // --- دکمه تایید ---

      Container(
        margin: EdgeInsets.only(right: 30, left: 30),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:AppColors.splashGradiantColor1,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.12)),
                borderRadius: BorderRadius.all(Radius.circular(8))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('تایید و ادامه',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.appWhite
                ),
              ),
              AppSpace.widthSpace_5,
              Icon(Icons.arrow_forward,
                  color: AppColors.appWhite
              )
            ],
          ),
          onPressed: (){},
        ),
      ),
      AppSpace.heightSpace_32,

      // --- عنوان مخاطبین ---

      Container(
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 30, left: 30, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('مخاطبین پر تکرار',
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.primaryFixed,
                    ),
                  ),
                  Text('مشاهده همه',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.splashGradiantColor1
                    ),
                  )
                ],
              ),
            ),
            AppSpace.heightSpace_24,

            // --- لیست مخاطبین ---

            SizedBox(
              height: 80,
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  separatorBuilder: (_, __) => const SizedBox(width: 24),
                  itemBuilder: (context, index) =>
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                            child: SvgPicture.asset(
                              'assets/svg/fund_transfer_page/user-01.svg',
                              fit: BoxFit.fill,
                            ),
                          ),
                          AppSpace.heightSpace_12,
                          Text('احسان علیمردانی',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primaryFixed,
                            ),
                          )
                        ],
                      ),
                ),
              ),
            )
          ],
        ),
      )


    ],
  )
  ;
}