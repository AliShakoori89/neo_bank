import 'package:flutter/material.dart';

class StackCircle extends StatelessWidget {
  const StackCircle({super.key, this.rightPosition, this.leftPosition, this.topPosition, this.bottomPosition, required this.width, required this.height, this.circleColor});

  final double? rightPosition;
  final double? leftPosition;
  final double? topPosition;
  final double? bottomPosition;
  final Color? circleColor;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: rightPosition,
      left: leftPosition,
      top: topPosition,
      bottom: bottomPosition,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: circleColor ?? Colors.grey.withAlpha(70),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
