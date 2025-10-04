import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage('assets/image/user.png'),
              fit: BoxFit.fill
          ),
          border: Border.all(
              width: 1,
              color: Color.fromRGBO(0, 0, 0, 0.08)
          )
      ),
    );
  }
}
