import 'package:budgeting_app/core/constants/colors.dart';
import 'package:flutter/cupertino.dart';

Widget backButton(
  BuildContext context, {
  void Function()? onPressed,
  Color color = ColorCodes.buttonColor,
  IconData icon = CupertinoIcons.back,
  Color iconColor = ColorCodes.appBackground,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: 56.0,
      height: 56.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          color: iconColor,
          size: 39.0,
        ),
      ),
    ),
  );
}
