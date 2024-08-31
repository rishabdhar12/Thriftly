import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textWidget({
  String text = "",
  double fontSize = 14.0,
  FontWeight fontWeight = FontWeight.normal,
  Color color = Colors.white,
  double? letterSpacing,
  TextAlign textAlign = TextAlign.start,
  TextOverflow overflow = TextOverflow.clip,
  int? maxLines,
}) {
  return Text(
    text,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    style: GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    ),
  );
}
