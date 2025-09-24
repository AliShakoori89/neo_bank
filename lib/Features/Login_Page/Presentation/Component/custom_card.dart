import 'package:flutter/material.dart';

class CustomCardWithBorder extends StatelessWidget {
  const CustomCardWithBorder({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black,
              width: 2
          ),
          borderRadius: BorderRadius.circular(15)
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(
              right: 10,
              left: 10
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black
                ),
              ),
              Icon(Icons.arrow_forward,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
