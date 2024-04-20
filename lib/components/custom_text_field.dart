import 'package:flutter/material.dart';
import 'theme.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;

  CustomTextField({required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.navyBlue,
            fontFamily: 'Oswald'),
      ),
    );
  }
}
