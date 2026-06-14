import 'package:flutter/material.dart';

/// Shadow system — matches HTML design exactly
class AppShadows {
  AppShadows._();

  /// --shadow-xs: 0 1px 2px rgba(28,25,23,0.04)
  static const List<BoxShadow> xs = [
    BoxShadow(
      color: Color(0x0A1C1917),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];

  /// --shadow-sm: 0 1px 4px rgba(28,25,23,0.06)
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x0F1C1917),
      blurRadius: 4,
      offset: Offset(0, 1),
    ),
  ];

  /// --shadow-md: 0 4px 16px rgba(28,25,23,0.08)
  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x141C1917),
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];

  /// --shadow-pink: 0 4px 16px rgba(212,83,126,0.25)
  static const List<BoxShadow> pink = [
    BoxShadow(
      color: Color(0x40D4537E),
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];

  /// FAB shadow
  static const List<BoxShadow> fab = [
    BoxShadow(
      color: Color(0x59D4537E),
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
  ];
}
