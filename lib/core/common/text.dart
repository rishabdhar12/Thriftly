import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget text({
  String text = "",
  double fontSize = 14.0,
  FontWeight fontWeight = FontWeight.normal,
  Color color = Colors.white,
  double? letterSpacing,
  TextAlign textAlign = TextAlign.start,
}) {
  return Text(
    text,
    textAlign: textAlign,
    style: GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    ),
  );
}
