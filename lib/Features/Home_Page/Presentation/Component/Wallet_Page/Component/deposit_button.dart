import 'package:flutter/material.dart';
import '../../../../../../Core/Theme/app_colors.dart';
import '../../../../../../Core/Spacing/app_space.dart';

class DepositButton extends StatelessWidget {
  const DepositButton({super.key, required this.function});

  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: function,
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.grey.withAlpha(25),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add,
                size: 20,
                color: AppColors.splashGradiantColor1,
              ),
              AppSpace.widthSpace_5,
              Text('واریز',
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
