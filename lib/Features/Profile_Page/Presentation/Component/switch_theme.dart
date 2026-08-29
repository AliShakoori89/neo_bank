import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Theme/app_colors.dart';
import '../Bloc/Change_Theme_Bloc/change_theme_bloc.dart';

Widget buildThemeSwitch(BuildContext context) => Row(
  children: [
    const Icon(
      Icons.light_mode,
      size: 20,
      color: AppColors.loginPageIconColor,
    ),
    SizedBox(
      height: 24,
      width: 40,
      child: Transform.scale(
        scale: 0.7,
        child: Switch(
          value: Theme.of(context).brightness == Brightness.dark,
          activeTrackColor: AppColors.splashGradiantColor1,
          onChanged: (_) {
            context.read<ThemeBloc>().add(ThemeEvent.toggle);
          },
        ),
      ),
    ),
    const Icon(
      Icons.dark_mode,
      size: 20,
      color: AppColors.loginPageIconColor,
    ),
  ],
);