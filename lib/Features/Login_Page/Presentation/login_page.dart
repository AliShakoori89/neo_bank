import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';

import '../../../Core/Const/stack_circle.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SizedBox(
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
                children: [
                  AppSpace.heightSpace_128,
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/Logo/qbank.png"),
                          scale: 0.8,
                          colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn)
                        )
                      ),
                    ),
                  ),
                  AppSpace.heightSpace_32,
                  Container(
                    margin: EdgeInsets.only(
                      left: 50,
                      right: 50
                    ),
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey),
                      color: Colors.white54
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 10,
                        right: 10
                      ),
                      child: Column(
                        children: [
                          Form(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'نام کاربری',
                                hintStyle: TextStyle(
                                  color: Colors.grey
                                ),
                                hintTextDirection: TextDirection.rtl,
                                contentPadding: EdgeInsets.only(
                                  right: 20,
                                  top: 10
                                )
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Form(
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'پسوورد',
                                  hintStyle: TextStyle(
                                      color: Colors.grey
                                  ),
                                  hintTextDirection: TextDirection.rtl,
                                  contentPadding: EdgeInsets.only(
                                      right: 20,
                                      bottom: 10
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSpace.heightSpace_32,
                  Container(
                    margin: EdgeInsets.only(
                      left: 50,
                      right: 50
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            Colors.blueAccent),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0), // Adjust for desired corner radius
                          ),
                        ),
                      ),
                      onPressed: (){

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('ورود با اثر انگشت',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          AppSpace.widthSpace_8,
                          Icon(Icons.fingerprint,
                            color: Colors.white,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSpace.heightSpace_16,
                  InkWell(
                    onTap: (){
                      context.push('/cant_login');
                    },
                    child: Text('نمی توانید وارد شوید؟',
                      style: TextStyle(
                        color: Colors.blueAccent
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
