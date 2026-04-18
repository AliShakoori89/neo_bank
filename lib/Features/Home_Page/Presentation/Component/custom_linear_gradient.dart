import 'package:flutter/material.dart';

customLinearGradient(context){
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors:
    Theme.of(context).colorScheme.tertiaryFixed ==
        const Color(0xFFFFFFFF)
        ? [
      const Color(0xFFF3FEE7),
      const Color(0xFFF3FEE7).withAlpha(0),
    ]
        : [
      const Color(0xFF2B5314),
      const Color(0xFF2B5314).withAlpha(0),
    ],
  );
}