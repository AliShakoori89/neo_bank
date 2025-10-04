import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../Core/Const/app_colors.dart';
import '../../../../Core/Const/app_space.dart';
import '../../../../Core/Const/stack_circle.dart';
import 'login_header.dart';

class ForgetUsername extends StatelessWidget {
  const ForgetUsername({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('در ادامه کد تایید برای شما ارسال می گردد.'),
          AppSpace.widthSpace_8,
          FloatingActionButton(
            backgroundColor: AppColors.splashGradiantColor1,
            onPressed: (){

            },
            child: Center(
              child: Icon(Icons.arrow_forward_ios,
                color: AppColors.appWhite,
              ),
            ),
          ),
        ],
      ),
      body:Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.loginPageGradiantColor1, // #E6E6FA
              AppColors.loginPageGradiantColor2, // #B0E0E6
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpace.heightSpace_32,
            LoginHeader(
              title: 'فراموشی رمز کاربری؟',
              iconData: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: (){
                  context.pop();
                },
              ),
            ),
            AppSpace.heightSpace_32,
            Padding(
              padding: EdgeInsets.only(
                  right: 20),
              child: Text('شماره تلفن همراه خود را وارد کنید.',
                style: TextStyle(
                    color: Colors.black
                ),
              ),
            ),
            AppSpace.heightSpace_12,
            Padding(
              padding: EdgeInsets.only(
                  right: 20,
                  left: 20
              ),
              child: Form(
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  inputFormatters: [],
                  textDirection: TextDirection.ltr,
                  maxLength: 11,

                  decoration: InputDecoration(
                    hintText: 'شماره همراه خود را وارد نمایید.',
                    hintStyle: TextStyle(
                        color: Colors.grey[400]
                    ),
                    prefixIcon: Icon(Icons.sim_card,
                      color: AppColors.loginPageTextColor,
                    ),
                    hintTextDirection: TextDirection.rtl,
                    contentPadding: EdgeInsets.only(
                        right: 20,
                        top: 10
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.loginPageTextColor,),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.loginPageTextColor,),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue, width: 1),
                    ),
                  ),
                ),
              ),
            ),

          ],
        )
      )
    );
  }
}
