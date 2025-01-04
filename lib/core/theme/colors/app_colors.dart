import 'package:dailyquotes/core/theme/colors/contrast_color_helper.dart';
import 'package:flutter/material.dart';

abstract class AppColors {
  static Color get background => Color(0xff303b4d);
  static Color primary = Color(0xfff48bc4);
  static Color secondaryPrimary = Color(0xffa23bae);
  static Color get defaultAddbtnColor => Color.fromARGB(255, 96, 143, 243);
  static Color get unselectedItemColor => Color(0xff687389);
  static Color get selectedItemColor => Color(0xfff48bc4);
  static const List<Color> gradientColors = [
    Color(0xfffcaac4),
    Color(0xfff48bc4),
    Color(0xffa23bae),
  ];

  static Color get text => Colors.white;
  static Color get icon =>
      ContrastColorHelper.contrastColor(primary, secondaryPrimary);
}