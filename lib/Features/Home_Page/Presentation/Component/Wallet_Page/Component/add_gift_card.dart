import 'package:flutter/material.dart';
import '../../../../../../Core/Theme/app_colors.dart';
import '../../../../../../Core/Spacing/app_space.dart';

class AddGiftCard extends StatelessWidget {
  const AddGiftCard({super.key});

  @override
  Widget build(BuildContext context) {
    return                           Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('کارت هدیه',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primaryFixed,
          ),
        ),
        Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.grey.withAlpha(30),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.add,
                  size: 15,
                  color: AppColors.splashGradiantColor1,
                ),
                AppSpace.widthSpace_5,
                Text('افزودن کد هدیه')
              ],
            ),
          ),
        ),
      ],
    );
  }
}
