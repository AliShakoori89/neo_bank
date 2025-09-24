import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../Core/Const/app_space.dart';
import '../../../../Core/Const/stack_circle.dart';
import 'custom_header.dart';

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
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: (){

            },
            child: Center(
              child: Icon(Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body:SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            StackCircle(
                circleColor: Theme.of(context).primaryColor,
                topPosition: -40,
                width: 500,
                height: 500),
            StackCircle(
                circleColor: Theme.of(context).primaryColor,
                topPosition: 300,
                leftPosition: -30,
                width: 400,
                height: 400),
            StackCircle(
                circleColor: Theme.of(context).primaryColor,
                topPosition: 600,
                leftPosition: 200,
                width: 300,
                height: 300),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpace.heightSpace_32,
                CustomHeader(
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
                      decoration: InputDecoration(
                          hintText: 'شماره همراه خود را وارد نمایید.',
                          hintStyle: TextStyle(
                              color: Colors.grey[400]
                          ),
                          prefixIcon: Icon(Icons.sim_card,
                            color: Colors.black,
                          ),
                          hintTextDirection: TextDirection.rtl,
                          contentPadding: EdgeInsets.only(
                              right: 20,
                              top: 10
                          ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            )
          ],
        ),
      )
    );
  }
}
