import 'package:flutter/material.dart';

class ActionIcon extends StatelessWidget {
  final bool isDeposit;

  const ActionIcon({super.key, required this.isDeposit});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDeposit
            ? Theme.of(context).colorScheme.inverseSurface
            : Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Icon(
        isDeposit ? Icons.arrow_downward : Icons.arrow_upward,
        size: 16,
        color: isDeposit
            ? Theme.of(context).colorScheme.onSecondary
            : Theme.of(context).colorScheme.onInverseSurface,
      ),
    );
  }
}