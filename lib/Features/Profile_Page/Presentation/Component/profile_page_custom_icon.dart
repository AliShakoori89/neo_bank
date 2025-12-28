import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePageCustomIcon extends StatelessWidget {
  const ProfilePageCustomIcon({super.key, required this.iconPath});

  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).cardTheme.color,
      ),
      child: SvgPicture.asset(
        iconPath,
        fit: BoxFit.fill,
        width: 16,
        height: 16,
        colorFilter: ColorFilter.mode(
          Theme.of(context).iconTheme.color!,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
