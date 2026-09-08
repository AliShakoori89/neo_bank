import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key, required this.title, required this.iconData});

  final String title;
  final IconButton iconData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        iconData,
        SizedBox(
          width: MediaQuery.of(context).size.width / 3 - 40,
        ),
        Text(title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16
            )
        ),
      ],
    );
  }
}
