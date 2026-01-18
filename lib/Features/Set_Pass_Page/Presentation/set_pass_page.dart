import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Core/Theme/app_them.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/neo_bank_logo.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Bloc/Change_Theme_Bloc/change_theme_bloc.dart'
    show ThemeBloc;

class SetPassPage extends StatelessWidget {
  const SetPassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, theme) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: theme == AppTheme.lightTheme
                    ? [
                        Theme.of(context).colorScheme.primaryContainer,
                        Theme.of(context).colorScheme.secondaryContainer,
                      ]
                    : [
                        Theme.of(context).colorScheme.primaryContainer,
                        Theme.of(context).colorScheme.primaryContainer,
                        Theme.of(context).colorScheme.secondaryContainer,
                        Theme.of(context).colorScheme.secondaryContainer,
                      ],
              ),
            ),
            child: Column(
              children: [
                AppSpace.heightSpace_128,
                NeoBankLogo(
                  logoColor: AppColors.splashGradiantColor1,
                  logoWidth: 98,
                  logoHeight: 24,
                  space: 5,
                ),
                AppSpace.heightSpace_128,
                Container(
                  margin: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    bottom: 24,
                    top: 24,
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 24,
                    bottom: 24,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.splashGradiantColor2.withAlpha(30),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
