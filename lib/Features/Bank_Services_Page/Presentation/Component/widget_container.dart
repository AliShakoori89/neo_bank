import 'package:flutter/material.dart';

Widget widgetContainer(context, customList){
  return Container(
      margin: EdgeInsets.only(
          top: 16,
          bottom: 16
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(10, 13, 18, 0.05),
              offset: const Offset(0, 1), // x=0, y=1
              blurRadius: 2, // همون blur
              spreadRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          border: BoxBorder.all(
            color: Theme.of(context).colorScheme.surfaceDim,
            width: 1,
          )
      ),
      child: GridView.count(
        shrinkWrap: true, // تا ارتفاع درست حساب بشه
        physics: NeverScrollableScrollPhysics(), // چون داخل صفحه دیگه‌ای هست
        crossAxisCount: 4, // تعداد ستون‌ها = 4
        padding: EdgeInsets.all(
            12
        ),
        mainAxisSpacing: 20,
        children: customList,
      )
  );
}