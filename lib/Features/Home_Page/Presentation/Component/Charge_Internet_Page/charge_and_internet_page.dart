import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_contact_picker_plus/model/contact_model.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/custom_disable_button.dart';
import '../../../../../Core/Const/app_space.dart';
import '../../../../../Core/Utils/app_snackbar.dart';
import '../../../../../Core/Utils/custom_button.dart';
import 'package:flutter_native_contact_picker_plus/flutter_native_contact_picker_plus.dart';

import 'Component/convert_phonenumber.dart';
import 'Component/custom_header.dart';


class ChargeAndInternetPage extends StatefulWidget {
  const ChargeAndInternetPage({super.key});

  @override
  State<ChargeAndInternetPage> createState() => _ChargeAndInternetPageState();
}

class _ChargeAndInternetPageState extends State<ChargeAndInternetPage> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  final TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> phoneNumberFormKey = GlobalKey<FormState>();

  String? selectedOperator;
  String? selectedSimType;

  final FlutterContactPickerPlus _contactPicker = FlutterContactPickerPlus();
  List<Contact>? _contacts;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: theme.colorScheme.onPrimaryFixed,
        body: SafeArea(
          child: Column(
            children: [
              CustomHeader(title: 'شارژ و اینترنت', hasBackArrow: false,),
              SizedBox(
                height: 56,
                width: double.infinity,
                child: TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'شارژ مستقیم'),
                    Tab(text: 'بسته اینترنت'),
                  ],
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerHeight: 0,
                  labelColor: AppColors.splashGradiantColor2,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: AppColors.splashGradiantColor2,
                  indicatorWeight: 1.0,
                  splashFactory: NoSplash.splashFactory,
                ),
              ),
              Container(
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
                            onPressed: () async{
                              Contact? contact = await _contactPicker.selectContact();
                              setState(() {
                                _contacts = contact == null ? null : [contact];
                                phoneNumberController.text = convertPhoneNumber(_contacts!.first.phoneNumbers![0].toString());
                              });
                            },
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
                                hintText: '09XXXXXXXXX',
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
                          child: InkWell(
                            splashColor: Colors.transparent,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4), // پدینگ کم
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(child: Icon(Icons.sim_card, color: Colors.amber)),
                                  const SizedBox(width: 2), // فاصله بسیار کم
                                  Expanded(child: Icon(Icons.keyboard_arrow_down)),
                                ],
                              ),
                            ),
                            onTap: () {
                              selectOperatorType(context, selectedOperator);
                            },
                          ),
                        ),
                      ],
                    ),
                    AppSpace.heightSpace_32,
                    CustomButton(
                      buttonTitle: 'تایید',
                      buttonOnPressed: (){
          
                        if (phoneNumberFormKey.currentState!.validate()) {
                          if (selectedOperator == null) {
                            AppSnackBar.errorTop(context, 'لطفاً اپراتور خود را انتخاب کنید');
                            return;
                          }
          
                          if (selectedSimType == null) {
                            AppSnackBar.errorTop(context, 'لطفاً نوع سیم کارت خود را انتخاب کنید');
                            return;
                          }
          
                          if(_tabController.index == 0){
                            context.push('/directive_charge_page');
                          }else{
                            context.push('/internet_package_page', extra: {
                              'selectedOperator': selectedOperator == 'همراه اول' ? 2 : selectedOperator == 'ایرانسل' ? 1 : 15,
                              'selectedSimType': selectedSimType == 'دائمی' ? 1
                                  : selectedSimType == 'اعتباری' ? 2
                                  : selectedSimType == 'دائمی- اعتباری' ? 3
                                  : selectedSimType == 'دیتا – دائمی' ? 4
                                  : 5,
                              'phoneNumber': phoneNumberController.text,
          
                            });
                          }
                        }
          
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

  void selectOperatorType(BuildContext context, String? selectedOperator) {
    String? tempSelectedOperator = selectedOperator;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          expand: false,
          builder: (context, scrollController) {
            return StatefulBuilder(
              builder: (context, setStateSheet) {  // به setStateSheet تغییر نام دادم
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        child: RadioGroup<String>(
                          groupValue: tempSelectedOperator,  // استفاده از tempSelectedOperator
                          onChanged: (String? value) {
                            setStateSheet(() {  // استفاده از setStateSheet
                              tempSelectedOperator = value;  // تغییر tempSelectedOperator
                            });
                          },
                          child: ListView(
                            controller: scrollController,
                            children: [
                              ...['همراه اول', 'ایرانسل', 'رایتل'].asMap().entries.map((entry) {
                                int index = entry.key;
                                String operator = entry.value;
                                return Column(
                                  children: [
                                    RadioListTile<String>(
                                      title: Text(operator),
                                      value: operator,
                                    ),
                                    if (index < 2)
                                      Divider(height: 1, color: Theme.of(context).dividerColor),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      tempSelectedOperator != null  // این شرط الان درست کار می‌کند
                          ? CustomButton(
                        buttonTitle: 'تایید',
                        buttonOnPressed: () {
                          setState(() {
                            this.selectedOperator = tempSelectedOperator;
                          });
                          Navigator.pop(context);
                          selectSimType(context, selectedSimType);
                        },
                      )
                          : CustomDisableButton(),
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
      print('Selected operator: $selectedOperator');
    });
  }

  void selectSimType(BuildContext context, String? selectedSimType) {
    String? tempSelectedSimType = selectedSimType;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return StatefulBuilder(
              builder: (context, setStateSheet) {  // به setStateSheet تغییر نام دادم
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            'انتخاب نوع سیم کارت',
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
                        child: RadioGroup<String>(
                          groupValue: tempSelectedSimType,  // استفاده از tempSelectedOperator
                          onChanged: (String? value) {
                            setStateSheet(() {  // استفاده از setStateSheet
                              tempSelectedSimType = value;  // تغییر tempSelectedOperator
                            });
                          },
                          child: ListView(
                            controller: scrollController,
                            children: [
                              ...['دائمی', 'اعتباری', 'دائمی-اعتباری', 'دیتا -دائمی', 'دیتا - اعتباری'].asMap().entries.map((entry) {
                                int index = entry.key;
                                String operator = entry.value;
                                return Column(
                                  children: [
                                    RadioListTile<String>(
                                      title: Text(operator),
                                      value: operator,
                                    ),
                                    if (index < 4)
                                      Divider(height: 1, color: Theme.of(context).dividerColor),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      tempSelectedSimType != null  // این شرط الان درست کار می‌کند
                          ? CustomButton(
                        buttonTitle: 'تایید',
                        buttonOnPressed: () {
                          setState(() {
                            this.selectedSimType = tempSelectedSimType;
                          });
                          Navigator.pop(context);

                        },
                      )
                          : CustomDisableButton(),
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
      print('Selected operator: $selectedOperator');
    });
  }
}
