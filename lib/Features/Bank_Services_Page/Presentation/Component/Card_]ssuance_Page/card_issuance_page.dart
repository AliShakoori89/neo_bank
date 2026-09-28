import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../../Core/Spacing/app_space.dart';
import '../../../../../Core/Theme/app_colors.dart';
import '../../../../../Core/Widgets/custom_button.dart';
import '../../../../../Core/Widgets/custom_disable_button.dart';
import '../../../../Fund_Transfer_Page/Presentation/component/Gift_Tab_Body/Component/custom_vertical_divider.dart';

class CardIssuancePage extends StatefulWidget {
  const CardIssuancePage({super.key});

  @override
  State<CardIssuancePage> createState() => _CardIssuancePageState();
}

class _CardIssuancePageState extends State<CardIssuancePage> {

  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppSpace.heightSpace_90,
              Text('دریافت کارت بدون مراجعه به شعبه',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18
                ),
              ),
              AppSpace.heightSpace_48,
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary, size: 24)),
                  AppSpace.widthSpace_8,
                  Expanded(
                    flex: 15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('${'1'.toPersianDigit()}.',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            AppSpace.widthSpace_5,
                            Text('ثبت درخواست',
                              style: Theme.of(context).textTheme.titleMedium,),
                            AppSpace.widthSpace_5,
                          ],
                        ),
                        AppSpace.heightSpace_4,
                        Text('اگر کارت بانکی شما مفقود، خراب یا منقضی شده است یا دارای خسابی هستید که کارت ندارد، می توانید بدون مراجعه به شعبه، درخواست صدور کارت نمایید',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          textAlign: TextAlign.justify,)
                      ],
                    ),
                  )
                ],
              ),
              CustomVerticalDivider(),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary, size: 24)),
                  AppSpace.widthSpace_8,
                  Expanded(
                    flex: 15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('${'2'.toPersianDigit()}.',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            AppSpace.widthSpace_5,
                            Text('بررسی توسط بانک',
                              style: Theme.of(context).textTheme.titleMedium,),
                            AppSpace.widthSpace_5,
                          ],
                        ),
                        AppSpace.heightSpace_4,
                        Text('درخواست شما توسط بانک بررسی شده و کارت بانکی جدید برای شما صادر خواهد شد.',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          textAlign: TextAlign.justify,)
                      ],
                    ),
                  )
                ],
              ),
              CustomVerticalDivider(),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary, size: 24)),
                  AppSpace.widthSpace_8,
                  Expanded(
                    flex: 15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('${'3'.toPersianDigit()}.',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            AppSpace.widthSpace_5,
                            Text('ارسال کارت',
                              style: Theme.of(context).textTheme.titleMedium,),
                            AppSpace.widthSpace_5,
                          ],
                        ),
                        AppSpace.heightSpace_4,
                        Text('در کمتر از 7 روز کاری، کارت جدید توسط پست تح.یل شما داده خواهد شد. طی این مدت از مراجعه به شعبه و دریافت کارتی دیگر خودداری نمایید.',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          textAlign: TextAlign.justify,
                        )
                      ],
                    ),
                  )
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _isSwitched,
                        activeColor: Theme.of(context).colorScheme.primary,
                        onChanged: (value) {
                          setState(() {
                            _isSwitched = value ?? false;
                          });
                        },
                      ),
                      Text('شرایط و قوانین را خوانده و پذیرفته ام.'),
                    ],
                  ),
                  Divider(
                    color: AppColors.loginPageHintFontColor,
                  ),
                  AppSpace.heightSpace_8,
                  _isSwitched
                      ? CustomButton(
                    buttonOnPressed: (){
                      // context.push('select_design_page', extra: {
                      //   'phoneNumber': widget.phoneNumber,
                      // });
                    },
                    buttonTitle: 'تایید و ادامه',)
                      : CustomDisableButton(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
