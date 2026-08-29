import 'package:flutter/material.dart';
import '../Spacing/app_space.dart';

class NoDataReceive extends StatelessWidget {
  const NoDataReceive({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/image/no-data-availible.png', color: Colors.grey,),
        AppSpace.heightSpace_12,
        Text(
          description,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
