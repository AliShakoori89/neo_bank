import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class StatementListShimmer extends StatelessWidget {
  const StatementListShimmer({super.key, required this.itemCount});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      cacheExtent: 50,
      itemBuilder: (context, index){
        return Padding(
          padding: EdgeInsetsGeometry.only(
            bottom: 8
          ),
          child: SizedBox(
            width: double.infinity,
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
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
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
