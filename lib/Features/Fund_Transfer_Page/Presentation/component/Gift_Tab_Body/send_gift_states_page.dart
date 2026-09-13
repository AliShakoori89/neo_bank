import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Spacing/app_space.dart';
import 'package:neo_bank_mehr_iran/Core/Theme/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Widgets/custom_disable_button.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/component/Gift_Tab_Body/Component/custom_vertical_divider.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../../../Core/Widgets/custom_button.dart';

class SendGiftStatesPage extends StatefulWidget {
  const SendGiftStatesPage({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<SendGiftStatesPage> createState() => _SendGiftStatesPageState();
}

class _SendGiftStatesPageState extends State<SendGiftStatesPage> {

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
              Text('مراحل ارسال هدیه آنلاین',
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
                            Text('انتخاب طرح',
                              style: Theme.of(context).textTheme.titleMedium,),
                            AppSpace.widthSpace_5,
                          ],
                        ),
                        AppSpace.heightSpace_4,
                        Text('طرح مورد نظر خود را انتخاب کرده و پیام متنی و صوتی دلخواه خود را اضافه نمایید.',
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
                            Text('پرداخت',
                              style: Theme.of(context).textTheme.titleMedium,),
                            AppSpace.widthSpace_5,
                          ],
                        ),
                        AppSpace.heightSpace_4,
                        Text('بسته به مبلغ هدیه انتخاب شده، هزینه آن را پرداخت کنید. کارمزد ارسال هدیه ${'52400'.toPersianDigit().seRagham()} ریال می باشد.',
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
                            Text('اطلاع رسانی به گیرنده',
                              style: Theme.of(context).textTheme.titleMedium,),
                            AppSpace.widthSpace_5,
                          ],
                        ),
                        AppSpace.heightSpace_4,
                        Text('پس ار پرداخت، لینک دریافت هدیه از طریق پیامک و یا اشتراک گذاری به روش دلخواه خودتان به گیرنده اطلاع رسانی شده و ایشان می تواند هدیه خود را دریافت نماید.',
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
                      context.push('select_design_page', extra: {
                        'phoneNumber': widget.phoneNumber,
                      });
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
