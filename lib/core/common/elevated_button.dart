import 'package:budgeting_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

Widget elevatedButton({
  Color buttonColor = ColorCodes.buttonColor,
  double width = 0,
  double height = 0,
  Widget? textWidget,
  void Function()? onPressed,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: buttonColor,
      minimumSize: Size(width, height),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
    ),
    onPressed: onPressed,
    child: textWidget,
  );
}
