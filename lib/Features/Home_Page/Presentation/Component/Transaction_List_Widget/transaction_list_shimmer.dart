import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class TransactionListShimmer extends StatelessWidget {
  const TransactionListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index){
        return Padding(
          padding: const EdgeInsets.only(
            bottom: 5
          ),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: Shimmer(
              interval: Duration(microseconds: 100),
              //Default value: Duration(seconds: 0)
              color: Colors.grey,
              //Default value
              colorOpacity: 0.5,
              //Default value
              enabled: true,
              //Default value
              direction: ShimmerDirection.fromLTRB(),
              //Default Value
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
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
