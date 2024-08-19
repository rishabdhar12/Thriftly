import 'package:budgeting_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

Widget textFormField({
  Color fillColor = ColorCodes.lightGreen,
  String hintText = "",
  TextEditingController? controller,
  TextInputType textInputType = TextInputType.text,
  bool obscureText = false,
  IconData? icon,
  void Function()? onPressed,
  String? Function(String?)? validator,
  Widget? suffixIcon,
  bool enabled = true,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: fillColor,
    ),
    child: TextFormField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      enabled: enabled,
      validator: validator,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        border: InputBorder.none,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        hintText: hintText,
      ),
    ),
  );
}
