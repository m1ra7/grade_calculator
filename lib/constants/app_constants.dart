import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

bool isDarkMode(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

class Sabitler {
  static Color anaRenk(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.indigo;
  }

  static Color circleAvatarText(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white;
  }

  static TextStyle textStyle(
          double size, FontWeight fontWeight, Color colorName) =>
      GoogleFonts.quicksand(
          fontWeight: fontWeight, fontSize: size, color: colorName);

  static BorderRadius borderRadius = BorderRadius.circular(24);
}
