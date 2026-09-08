import 'package:flutter/material.dart';
import '../../../../../../Core/Theme/app_colors.dart';
import '../../../../../../Core/Spacing/app_space.dart';

class WithdrawButton extends StatelessWidget {
  const WithdrawButton({super.key, required this.function});

  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap:function,
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.grey.withAlpha(25),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.remove,
                size: 20,
                color: AppColors.redColor,
              ),
              AppSpace.widthSpace_5,
              Text('برداشت',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryFixed,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
