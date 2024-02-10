import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color textColor;
  final FontWeight textFontWeight;

  const AppText({super.key,
    required this.title,
    this.fontSize = 14,
    this.textColor = Colors.black,
    this.textFontWeight = FontWeight.normal
  });

  @override
  Widget build(BuildContext context) {
    return Text(title,
      maxLines: 3,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: textFontWeight,
        color: textColor,
    ),);
  }
}

class AppLargeText extends AppText{
  const AppLargeText({super.key, required super.title});

  @override
  Widget build(BuildContext context){
    return Text(title, );
  }
}