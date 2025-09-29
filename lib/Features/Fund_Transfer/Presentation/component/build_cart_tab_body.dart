import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Core/Const/app_colors.dart';
import '../../../../Core/Const/app_space.dart';

Widget buildCartTabBody(){
  return Container(
      margin: EdgeInsets.all(30),
      child: Column(
        children: [

          // --- مبلغ انتقال ---

          Form(
              child: SizedBox(
                height: 50,
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
                          color: Color(0xFF717680)
                      ),
                      border: OutlineInputBorder(borderSide: BorderSide(
                          color: AppColors.loginBorderColor
                      )),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.loginBorderColor
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
          AppSpace.heightSpace_32,

          // --- دکمه تایید ---

          ElevatedButton(
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
                Icon(Icons.arrow_forward,
                    color: AppColors.appWhite
                )
              ],
            ),
            onPressed: (){},
          ),
          AppSpace.heightSpace_32,

          // --- عنوان مخاطبین ---

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('مخاطبین پر تکرار',
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.homePageCardTitleColor
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
          AppSpace.heightSpace_24,

          // --- لیست مخاطبین ---

          SizedBox(
            height: 120,
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
                          backgroundColor: AppColors.noImageBackgroundColor,
                          child: SvgPicture.asset(
                            'assets/svg/fund_transfer_page/user-01.svg',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Text('احسان علیمردانی',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.customHeaderTextColor
                          ),
                        )
                      ],
                    ),
              ),
            ),
          )
        ],
      ));
}