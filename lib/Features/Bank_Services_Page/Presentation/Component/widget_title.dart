import 'package:flutter/material.dart';

Widget widgetTitle(context, title){
  return Text(title,
    style: TextStyle(
        color: Theme.of(context).textTheme.titleMedium!.color,
        fontSize: 12,
        fontWeight: FontWeight.w600
    ),
  );
}