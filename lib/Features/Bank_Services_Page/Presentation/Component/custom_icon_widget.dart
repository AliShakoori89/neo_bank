import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../Core/Spacing/app_space.dart';
import '../../../../Core/Theme/app_them.dart';
import '../../../Profile_Page/Presentation/Bloc/Change_Theme_Bloc/change_theme_bloc.dart';

class CustomIconWidget extends StatelessWidget {
  const CustomIconWidget({
    super.key,
    required this.iconPath,
    required this.iconName,
  });

  final String iconPath;
  final String iconName;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryFixed,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.surfaceDim,
                ),
              ),
              child: Center(
                child: BlocBuilder<ThemeBloc, ThemeData>(
                  builder: (context, theme) {
                    return Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiaryFixed,
                        boxShadow: [
                          theme == AppTheme.lightTheme
                              ? BoxShadow(
                                  color: const Color.fromRGBO(10, 13, 18, 0.10),
                                  offset: const Offset(0, -2),
                                  blurRadius: 2,
                                )
                              : BoxShadow(
                                  color: Color.fromRGBO(255, 255, 255, 0.00),
                                  offset: Offset(0, -2),
                                  blurRadius: 2,
                                  spreadRadius: 0,
                                  blurStyle: BlurStyle.inner, // 👈 معادل inset
                                ),
                          theme == AppTheme.lightTheme
                              ? BoxShadow(
                                  color: const Color.fromRGBO(10, 13, 18, 0.05),
                                  offset: const Offset(1, 8),
                                  blurRadius: 5,
                                )
                              : BoxShadow(
                                  color: Color.fromRGBO(255, 255, 255, 0.00),
                                  offset: Offset(1, 8),
                                  blurRadius: 5,
                                ),
                          theme == AppTheme.lightTheme
                              ? BoxShadow(
                                  color: const Color.fromRGBO(10, 13, 18, 0.10),
                                  offset: const Offset(0, 3),
                                  blurRadius: 3,
                                )
                              : BoxShadow(
                                  color: Color.fromRGBO(255, 255, 255, 0.00),
                                  offset: Offset(0, 3),
                                  blurRadius: 3,
                                ),
                          theme == AppTheme.lightTheme
                              ? BoxShadow(
                                  color: const Color.fromRGBO(10, 13, 18, 0.10),
                                  offset: const Offset(0, 1),
                                  blurRadius: 2,
                                )
                              : BoxShadow(
                                  color: Color.fromRGBO(255, 255, 255, 0.00),
                                  offset: Offset(0, 1),
                                  blurRadius: 2,
                                ),
                        ],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.surfaceDim,
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          iconPath,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).appBarTheme.iconTheme!.color!,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          AppSpace.heightSpace_8,
          Flexible(
            child: Text(
              iconName,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primaryFixed,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
