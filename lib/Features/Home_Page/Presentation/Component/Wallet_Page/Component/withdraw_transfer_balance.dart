import 'package:flutter/material.dart';
import '../../../../../../Core/Const/app_colors.dart';
import '../../../../../../Core/Const/app_space.dart';

class WithdrawTransferBalance extends StatelessWidget {
  const WithdrawTransferBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                topLeft: Radius.circular(30)
            ),
            color: Colors.white.withAlpha(25)
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: Colors.grey,
                        width: 2
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Transform.rotate(
                    angle: 180,
                    child: Icon(Icons.arrow_back_outlined,
                      size: 15,
                      color: AppColors.splashGradiantColor1,
                    ),
                  ),
                ),
              ),
              AppSpace.widthSpace_5,
              Text('برداشت / انتقال')
            ],
          ),
        ),
      ),
    );
  }
}
