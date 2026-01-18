import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PassTextField extends StatelessWidget {
  const PassTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(50),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: TextFormField(
            controller: controller,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(1),
            ],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
