import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.title, required this.iconData});

  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor.withAlpha(200),
              shape: BoxShape.circle
          ),
          child: Icon(iconData),
        ),
        Text(title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold
            ))
      ],
    );
  }
}
