import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class StatementListShimmer extends StatelessWidget {
  const StatementListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      cacheExtent: 50,
      itemBuilder: (context, index){
        return Padding(
          padding: EdgeInsetsGeometry.only(
            bottom: 2
          ),
          child: SizedBox(
            width: double.infinity,
            child: Shimmer(
              duration: Duration(seconds: 1), //Default value
              interval: Duration(
                seconds: 1,
              ), //Default value: Duration(seconds: 0)
              color: Colors.white, //Default value
              colorOpacity: 0.4, //Default value
              enabled: true, //Default value
              direction: ShimmerDirection.fromLTRB(), //Default Value
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
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
