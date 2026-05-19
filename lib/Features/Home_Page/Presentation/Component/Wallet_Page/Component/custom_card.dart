import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import '../../../../../../Core/Const/app_colors.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.theme, required this.isSelected, required this.onTap});

  final ThemeData theme;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [

          Padding(
            padding:EdgeInsets.only(
                right: 15
            ),
            child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: isSelected ? AppColors.splashGradiantColor1 : Colors.grey.withAlpha(30),
                        width: 2
                    )
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isSelected ? AppColors.circleBorderColor.withAlpha(500) : Colors.grey.withAlpha(30),
                  ),
                    margin: EdgeInsets.only(
                        right: 15,
                        left: 3,
                        bottom: 3,
                        top: 3
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 10,
                        right: 10
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('پرداخت اینترنتی',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? AppColors.homePageCardTitleColor : Theme.of(context).colorScheme.primaryFixed,
                            ),
                          ),
                          AppSpace.heightSpace_8,
                          Text('پرداخت از طریق درگاه اینترنتی',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    )
                )
            ),
          ),
          Positioned(
            top: 35,
            child: Container(
              decoration: BoxDecoration(
                  color: theme.colorScheme.onPrimaryFixed,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: isSelected ? AppColors.splashGradiantColor1 : Colors.grey.withAlpha(30),
                      width: 2
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: isSelected ? AppColors.splashGradiantColor1 : theme.colorScheme.onPrimaryFixed,
                      shape: BoxShape.circle
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
