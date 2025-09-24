import 'package:flutter/material.dart';

import '../../../../Core/Const/app_colors.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 5, left: 10, right: 10),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(25)
            // topLeft: Radius.circular(25),
            // topRight: Radius.circular(25)
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(20, 20),
              blurRadius: 25,
              color: Colors.black.withAlpha(20),
              spreadRadius: 25,
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 1,
          currentIndex: widget.currentIndex,
          backgroundColor: AppColors.primaryColor,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey[500],
          unselectedLabelStyle: TextStyle(
            color: Colors.grey[800],
            fontSize: 14,
          ),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: widget.onTap,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.compare_arrows),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.credit_card_rounded),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
        )
    );
  }
}
