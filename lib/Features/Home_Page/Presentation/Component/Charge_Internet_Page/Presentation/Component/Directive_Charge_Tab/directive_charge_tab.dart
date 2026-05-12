import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../../../../Core/Const/app_colors.dart';
import '../../../../../../../../Core/Const/app_space.dart';
import '../../../../../../../../Core/Utils/custom_button.dart';

class DirectiveChargeTab extends StatelessWidget {
  DirectiveChargeTab({super.key});

  TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> phoneNumberFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpace.heightSpace_32,
          Text(
            'شماره تلفن همراه را وارد نمایید',
            style: TextStyle(color: Theme.of(context).colorScheme.primaryFixed),
          ),
          AppSpace.heightSpace_8,
          Row(
            children: [
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.contacts_rounded, color: AppColors.splashGradiantColor2,),
                ),
              ),
              Expanded(
                flex: 9,
                child: Form(
                  key: phoneNumberFormKey,
                  child: TextFormField(
                    textDirection: TextDirection.ltr,
                    controller: phoneNumberController,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    style: TextStyle(
                      color: Theme.of(context).appBarTheme.titleTextStyle!.color,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'لطفا شماره همراه خود را وارد نمایید.';
                      }
                      if (value.length != 11) {
                        return 'شماره همراه وارد شده صحیح نمی باشد.';
                      }
                      if (value.startsWith('09') == false) {
                        return 'شماره همراه وارد شده صحیح نمی باشد.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: '09123456789',
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0,
                      ),
                      hintTextDirection: TextDirection.ltr,
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                      // تنظیم پدینگ عمودی
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
                        borderSide: BorderSide(
                          color: AppColors.splashGradiantColor2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Icon(Icons.sim_card, color: Colors.amber,)
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: (){
                          _showBottomSheet(context);
                        },
                        icon: Icon(Icons.keyboard_arrow_down),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpace.heightSpace_32,
          CustomButton(
            buttonTitle: 'تایید',
            buttonOnPressed: (){

            },
          ),
        ],
      ),
    );
  }

  String? selectedOperator;

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.45,  // ارتفاع اولیه 45% صفحه
          minChildSize: 0.3,      // حداقل ارتفاع 30% صفحه
          maxChildSize: 0.9,      // حداکثر ارتفاع 90% صفحه
          expand: false,
          builder: (context, scrollController) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // خط نشانگر برای کشیدن
                      Center(
                        child: Container(
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            'انتخاب اپراتور',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primaryFixed,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      const Divider(),
                      Expanded(
                        child: ListView(
                          controller: scrollController,
                          children: [
                            ...['همراه اول', 'ایرانسل', 'رایتل', 'شاتل موبایل'].map((operator) {
                              return RadioListTile<String>(
                                title: Text(operator),
                                value: operator,
                                groupValue: selectedOperator,
                                onChanged: (value) {
                                  setState(() {
                                    selectedOperator = value;
                                  });
                                },
                              );
                            }),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(buttonTitle: 'تایید', buttonOnPressed: (){}),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    ).then((_) {
      // پس از بسته شدن bottom sheet می‌توانید عملیاتی انجام دهید
      print('Selected operator: $selectedOperator');
    });
  }}
