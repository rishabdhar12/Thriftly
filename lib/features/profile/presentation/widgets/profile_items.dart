import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

Widget profileItems(
    {String title = "",
    String desc = "",
    IconData? icon,
    void Function()? onPressed}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 60.0,
      decoration: BoxDecoration(
        color: ColorCodes.transparentCard,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          textWidget(text: title, fontWeight: FontWeight.w600, fontSize: 16.0),
          icon != null
              ? Icon(
                  // CupertinoIcons.person,
                  icon,
                  color: ColorCodes.white,
                  size: 20.0,
                )
              : textWidget(text: desc, fontSize: 16.0),
        ],
      ),
    ),
  );
}
