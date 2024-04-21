import 'package:flutter/material.dart';
import 'theme.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText; // Şifre için metni gizlemek
  final TextInputType keyboardType; // Klavye türünü ayarlamak için

  CustomTextField({
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text, // Varsayılan olarak metin tipi
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.navyBlue,
          fontFamily: 'Oswald',
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), // Kenarlık yuvarlaklığı
        ),
      ),
    );
  }
}
