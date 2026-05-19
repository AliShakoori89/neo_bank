import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/Component/custom_text_form_field.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Wallet_Bloc/wallet_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Wallet_Bloc/wallet_state.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../../../Core/Utils/error_refresh_widget.dart';
import '../../Bloc/Wallet_Bloc/wallet_event.dart';
import '../Charge_Internet_Page/Component/custom_header.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {

  TextEditingController balanceController = TextEditingController();

  final GlobalKey<FormState> balanceFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: theme.colorScheme.onPrimaryFixed,
        body: Column(
          children: [
            CustomHeader(title: 'کیف پول'),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                              color: Theme.of(context).colorScheme.primaryFixed,
                            ),
                          ),
                          AppSpace.heightSpace_8,
                          Text('جزدیات موجودی باقی مانده در کیف پول',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          AppSpace.heightSpace_48, // کاهش از 128 به 48
                          Center(
                            child: Column(
                              children: [
                                Text('کل موجودی'),
                                AppSpace.heightSpace_16,
                                BlocBuilder<WalletBloc, WalletState>(
                                  builder: (context, state) {
                                    if (state.status.isLoading) {
                                      return SizedBox(
                                          width: 25,
                                          height: 25,
                                          child: const CircularProgressIndicator());
                                    } else if (state.status.isSuccess) {
                                      if (state.walletDetails != null && state.walletDetails!.isNotEmpty) {
                                        return Text(state.walletDetails!.first.balance.toString().toPersianDigit().seRagham(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18
                                          ),
                                        );
                                      } else {
                                        return const Text('کیف پولی یافت نشد');
                                      }
                                    } else if (state.status.isError) {
                                      return ErrorRefreshWidget(
                                        title: '',
                                        heightSize: 50,
                                        refreshFunction: () {
                                          context.read<WalletBloc>().add(WalletDetailsPackages());
                                        },
                                      );
                                    }
                                    return ErrorRefreshWidget(
                                      title: '',
                                      heightSize: 50,
                                      refreshFunction: () {
                                        context.read<WalletBloc>().add(WalletDetailsPackages());
                                      },
                                    );
                                  },
                                ),
                                AppSpace.heightSpace_16,
                                Text('ریال'),
                                AppSpace.heightSpace_24, // کاهش از 32 به 24
                                Container(
                                  width: double.infinity,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.grey.withAlpha(10)
                                  ),
                                ),
                                AppSpace.heightSpace_24, // کاهش از 32 به 24
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: (){
                                          increaseBalance(context);
                                        },
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(30),
                                                  topRight: Radius.circular(30)
                                              ),
                                              color: Colors.white.withAlpha(25)
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
                                                      color: AppColors.splashGradiantColor1,
                                                    ),
                                                  ),
                                                ),
                                                AppSpace.widthSpace_5,
                                                Text('افزودن موجودی')
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    AppSpace.widthSpace_5,
                                    Expanded(
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(30),
                                                topLeft: Radius.circular(30)
                                            ),
                                            color: Colors.white.withAlpha(25)
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
                                                      color: AppColors.splashGradiantColor1,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              AppSpace.widthSpace_5,
                                              Text('برداشت / انتقال')
                                            ],
                                          ),
                                        ),
                                      ),
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
                                  color: Theme.of(context).colorScheme.primaryFixed,
                                ),
                              ),
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
                                        color: AppColors.splashGradiantColor1,
                                      ),
                                      AppSpace.widthSpace_5,
                                      Text('افزودن کد هدیه')
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          AppSpace.heightSpace_32,

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  increaseBalance(BuildContext context){
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DraggableScrollableSheet(
              initialChildSize: 0.4, // افزایش از 0.35 به 0.5
              minChildSize: 0.4,
              maxChildSize: 0.8,
              expand: false,
              builder: (context, scrollController) {
                return StatefulBuilder(
                    builder: (context, setStateSheet) {
                      return SingleChildScrollView( // اضافه کردن SingleChildScrollView
                        controller: scrollController,
                        child: Container(
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
                                    'افزایش موجودی',
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
                              AppSpace.heightSpace_16, // کاهش فضا
                              Text('مبلغ مورد نظر خود را وارد نمایید:',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              AppSpace.heightSpace_8,
                              Form(
                                key: balanceFormKey,
                                child: TextFormField(
                                  textDirection: TextDirection.ltr,
                                  controller: balanceController,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  obscureText: false,
                                  autofocus: true, // اضافه کردن autofocus برای نمایش خودکار کیبورد
                                  style: TextStyle(
                                    color: Theme.of(context).appBarTheme.titleTextStyle?.color,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'لطفا مبلغ مورد نظر خود را وارد نمایید.';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    suffixText: ' ریال',
                                    hintStyle: TextStyle(
                                      color: Theme.of(context).colorScheme.surface,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0,
                                    ),
                                    hintTextDirection: TextDirection.ltr,
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12.0,
                                      horizontal: 12.0, // اضافه کردن padding افقی
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
                                      borderSide: const BorderSide(
                                        color: AppColors.splashGradiantColor2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              AppSpace.heightSpace_24, // اضافه کردن فضای خالی برای دکمه
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (balanceFormKey.currentState?.validate() ?? false) {
                                      // انجام عملیات افزایش موجودی
                                      print('مبلغ: ${balanceController.text}');
                                      Navigator.pop(context);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.splashGradiantColor1,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('تایید و ادامه'),
                                ),
                              ),
                              AppSpace.heightSpace_16, // فضای انتهایی
                            ],
                          ),
                        ),
                      );
                    }
                );
              }
          ),
        );
      },
    ).then((_) {
      // بعد از بسته شدن مودال، متن فیلد را پاک کنید
      balanceController.clear();
    });
  }}
