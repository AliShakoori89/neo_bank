import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomDropDownShimmer extends StatelessWidget {
  const CustomDropDownShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 30,
        right: 30
      ),
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[800]!,
        highlightColor: Colors.grey[200]!,
        period: Duration(milliseconds: 1500),
        direction: ShimmerDirection.ltr,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}