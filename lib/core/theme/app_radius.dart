import 'package:flutter/material.dart';

/// Border radius scale
class AppRadius {
  AppRadius._();

  static const double chip = 6;
  static const double sm = 10;
  static const double md = 14;
  static const double lg = 16;
  static const double xl = 18;
  static const double xxl = 22;
  static const double modal = 32;
  static const double phone = 52;
  static const double pill = 100;

  // BorderRadius helpers
  static BorderRadius get chipRadius => BorderRadius.circular(chip);
  static BorderRadius get smRadius => BorderRadius.circular(sm);
  static BorderRadius get mdRadius => BorderRadius.circular(md);
  static BorderRadius get lgRadius => BorderRadius.circular(lg);
  static BorderRadius get xlRadius => BorderRadius.circular(xl);
  static BorderRadius get pillRadius => BorderRadius.circular(pill);
  static BorderRadius get modalRadius => const BorderRadius.only(
        topLeft: Radius.circular(modal),
        topRight: Radius.circular(modal),
      );
}
