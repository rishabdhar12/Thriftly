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
  double borderRadius = 20.0,
  double? height,
  double contentPaddingHorizontal = 16.0,
  double contentPaddingVertical = 16.0,
  void Function(String)? onChanged,
  String? prefixText,
}) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      color: fillColor,
    ),
    child: TextFormField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      enabled: enabled,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixText: prefixText,
        suffixIcon: suffixIcon,
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(
          horizontal: contentPaddingHorizontal,
          vertical: contentPaddingVertical,
        ),
        hintText: hintText,
      ),
    ),
  );
}
