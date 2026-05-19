import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../../Core/Const/app_colors.dart';
import '../../../../../../Core/Const/app_space.dart';

class IncreaseBalance extends StatelessWidget {
  const IncreaseBalance({super.key, required this.balanceController, required this.balanceFormKey});

  final TextEditingController balanceController;
  final GlobalKey<FormState> balanceFormKey;

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
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}
