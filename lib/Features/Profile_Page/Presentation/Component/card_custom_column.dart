import 'package:flutter/material.dart';

import '../../../../Core/Spacing/app_space.dart';

class CardCustomColumn extends StatelessWidget {
  const CardCustomColumn({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return value != ''
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
              ),
              AppSpace.heightSpace_8,
              Text(
                value,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          )
        : Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primaryFixed,
              ),
            ),
          );
  }
}
