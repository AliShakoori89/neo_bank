import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget buildAddCardButton(BuildContext context) {
  return InkWell(
    onTap: () => context.push('/add_card_page'),
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade400, width: 2),
      ),
      child: const Center(
        child: Icon(Icons.add, size: 80, color: Colors.grey),
      ),
    ),
  );
}