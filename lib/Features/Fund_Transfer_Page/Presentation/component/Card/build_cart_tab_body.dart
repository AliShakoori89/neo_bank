import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../Core/Theme/app_colors.dart';
import '../../../../../Core/Spacing/app_space.dart';
import '../bank_card_selector.dart';

Widget buildCartTabBody(BuildContext context) {
  return SizedBox(
    height: double.infinity,
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppSpace.heightSpace_24,
        BankCardSelector(),
        AppSpace.heightSpace_24,
        SizedBox(
          height: 144,
          child: Column(
            children: [
              // --- مبلغ انتقال ---
              Form(
                child: Container(
                  margin: EdgeInsets.only(right: 30, left: 30),
                  height: 44,
                  color: Theme.of(context).colorScheme.outline,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      TextFormField(
                        textAlign: TextAlign.center, // hint و متن وسط
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          hintText: 'مبلغ انتقال',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.surfaceDim,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.surfaceDim,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16, // فاصله از سمت راست
                        child: Text(
                          'ریال',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primaryFixed,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              AppSpace.heightSpace_24,

              // --- دکمه تایید ---
              Container(
                height: 44,
                margin: EdgeInsets.only(right: 30, left: 30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.splashGradiantColor1,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color.fromRGBO(255, 255, 255, 0.12),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'تایید و ادامه',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.appWhite,
                        ),
                      ),
                      AppSpace.widthSpace_5,
                      Icon(
                        Icons.arrow_forward,
                        color: Theme.of(
                          context,
                        ).elevatedButtonTheme.style?.iconColor?.resolve({}),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
              AppSpace.heightSpace_32,
            ],
          ),
        ),

        // --- عنوان مخاطبین ---
        Container(
          color: Theme.of(context).colorScheme.surfaceContainer,
          height: 142,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 24, left: 24),
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'مخاطبین پر تکرار',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primaryFixed,
                          ),
                        ),
                        Text(
                          'مشاهده همه',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.splashGradiantColor1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              AppSpace.heightSpace_8,

              // --- لیست مخاطبین ---
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: SizedBox(
                  height: 82,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    separatorBuilder: (_, _) => const SizedBox(width: 5),
                    itemBuilder: (context, index) => SizedBox(
                      width: 74,
                      height: 82,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                              child: SvgPicture.asset(
                                'assets/svg/fund_transfer_page/user-01.svg',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          AppSpace.heightSpace_12,
                          Expanded(
                            flex: 1,
                            child: Text(
                              'احسان علیمردانی',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryFixed,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
