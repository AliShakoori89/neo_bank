import 'package:flutter/material.dart';

import '../Spacing/app_space.dart';

class ErrorRefreshWidget extends StatelessWidget {
  const ErrorRefreshWidget({super.key, required this.refreshFunction, this.heightSize, this.title});

  final Function refreshFunction;
  final double? heightSize;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: heightSize ?? 200,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title ?? 'برای تلاش مجدد کلیک کنید'),
            AppSpace.widthSpace_5,
            InkWell(
                onTap: (){
                  refreshFunction();
                  // BlocProvider.of<AllCardsBloc>(context).add(GetUserAllCardsEvent());
                },
                child: FutureBuilder(
                    future: Future.delayed(Duration(seconds: 5)),
                    builder: (context, asyncSnapshot) {
                      return Icon(Icons.refresh, size: 20,);
                    }
                )),
          ],
        ));
  }
}
