import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CustomDropDownShimmer extends StatelessWidget {
  const CustomDropDownShimmer({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 60,
          height: 40,
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          constraints: const BoxConstraints(minWidth: 320, minHeight: 40),
          child: Shimmer(
            duration: Duration(seconds: 2), //Default value
            interval: Duration(
              milliseconds: 100,
            ), //Default value: Duration(seconds: 0)
            //Default value
            colorOpacity: 5, //Default value
            enabled: true, //Default value
            direction: ShimmerDirection.fromLTRB(), //Default Value
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 62,
          height: 38,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
        )
      ],
    );
  }
}
