import 'package:flutter/material.dart';

Widget profileMainContainer(
    BuildContext context, {
      required List<Widget> children,
    }) {
  final theme = Theme.of(context);
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: theme.colorScheme.surfaceContainer,
    ),
    child: Column(children: children),
  );
}