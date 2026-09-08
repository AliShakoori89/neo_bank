import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class InternetPackageListShimmer extends StatelessWidget {
  const InternetPackageListShimmer({super.key, required this.itemCount});

  final int itemCount;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return ListView.builder(
      itemCount: itemCount,
      cacheExtent: 50,
      padding: EdgeInsets.only(
        right: 20,
        left: 20
      ),
      itemBuilder: (context, index){
        return Padding(
          padding: EdgeInsetsGeometry.only(
              bottom: 8
          ),
          child: SizedBox(
            width: double.infinity,
            height: 100,
            child: Shimmer(
              duration: Duration(seconds: 1), //Default value
              interval: Duration(
                seconds: 3,
              ), //Default value: Duration(seconds: 0)
              color: Colors.white, //Default value
              colorOpacity: 0.1, //Default value
              enabled: true, //Default value
              direction: ShimmerDirection.fromLTRB(), //Default Value
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: theme.cardColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
