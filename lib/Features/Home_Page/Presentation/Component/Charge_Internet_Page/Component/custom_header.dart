import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key, required this.title, this.hasBackArrow});

  final String title;
  final bool? hasBackArrow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 40, // spacing-5xl (مثلاً)
        right: 24, // spacing-3xl
        bottom: 16, // spacing-lg
        left: 24, // spacing-3xl
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.surfaceDim,
            width: 1,
          ),
        ),
      ),
      child: hasBackArrow == null
          ? Align(
          alignment: Alignment.centerRight,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: (){
                    context.pop();
                  },
                ),
              ),
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primaryFixed,
                  ),
                ),
              ),
            ],
          )
      )
          : Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primaryFixed,
          ),
        ),
      )
    );
  }
}
