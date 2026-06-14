import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// All text styles for Yaad.
/// DM Serif Display → headlines, brand moments
/// DM Sans          → body, UI labels
/// DM Mono          → timestamps, metadata, tags
class AppTypography {
  AppTypography._();

  // ── DM Serif Display ────────────────────────────────────────

  static TextStyle display({
    double fontSize = 32,
    Color color = AppColors.ink,
    FontStyle fontStyle = FontStyle.normal,
  }) =>
      GoogleFonts.dmSerifDisplay(
        fontSize: fontSize,
        color: color,
        fontStyle: fontStyle,
        letterSpacing: -0.5,
        height: 1.1,
      );

  static TextStyle displayItalic({
    double fontSize = 32,
    Color color = AppColors.ink,
  }) =>
      display(fontSize: fontSize, color: color, fontStyle: FontStyle.italic);

  // Specific display sizes matching design
  static TextStyle get splashTitle =>
      display(fontSize: 56, color: AppColors.white);
  static TextStyle get brandTitle =>
      display(fontSize: 88, color: AppColors.ink);
  static TextStyle get pageTitle => display(fontSize: 36, color: AppColors.ink);
  static TextStyle get sectionTitle =>
      display(fontSize: 32, color: AppColors.ink);
  static TextStyle get cardTitle => display(fontSize: 28, color: AppColors.ink);
  static TextStyle get entryTitle =>
      display(fontSize: 24, color: AppColors.ink);
  static TextStyle get modalTitle =>
      display(fontSize: 19, color: AppColors.ink);

  // ── DM Sans ─────────────────────────────────────────────────

  static TextStyle body({
    double fontSize = 15,
    FontWeight fontWeight = FontWeight.w400,
    Color color = AppColors.ink3,
  }) =>
      GoogleFonts.dmSans(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: 1.6,
      );

  // Specific body sizes
  static TextStyle get bodyLarge => body(fontSize: 15, color: AppColors.ink2);
  static TextStyle get bodyRegular => body(fontSize: 14, color: AppColors.ink2);
  static TextStyle get bodySmall => body(fontSize: 13, color: AppColors.ink3);
  static TextStyle get bodyXSmall => body(fontSize: 12, color: AppColors.ink3);

  static TextStyle get labelLarge =>
      body(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.ink);
  static TextStyle get labelMedium =>
      body(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.ink);
  static TextStyle get labelSmall =>
      body(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.ink);
  static TextStyle get labelXSmall =>
      body(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.ink4);

  static TextStyle get taskTitle =>
      body(fontSize: 14.5, fontWeight: FontWeight.w500, color: AppColors.ink);
  static TextStyle get taskTitleDone =>
      body(fontSize: 14.5, fontWeight: FontWeight.w500, color: AppColors.ink4)
          .copyWith(decoration: TextDecoration.lineThrough);

  static TextStyle get sectionHeader =>
      body(fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.ink);
  static TextStyle get buttonText =>
      body(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.white);

  static TextStyle get greeting => GoogleFonts.dmSerifDisplay(
        fontSize: 32,
        color: AppColors.ink,
        letterSpacing: -0.5,
        height: 1.1,
      );

  // ── DM Mono ─────────────────────────────────────────────────

  static TextStyle mono({
    double fontSize = 12,
    Color color = AppColors.ink4,
    FontWeight fontWeight = FontWeight.w400,
  }) =>
      GoogleFonts.dmMono(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        letterSpacing: 0.2,
      );

  static TextStyle get monoSmall => mono(fontSize: 10, color: AppColors.ink4);
  static TextStyle get monoMeta => mono(fontSize: 11.5, color: AppColors.ink4);
  static TextStyle get monoLabel =>
      mono(fontSize: 11, color: AppColors.ink4, fontWeight: FontWeight.w500);
  static TextStyle get monoBrand =>
      mono(fontSize: 11, color: AppColors.pink).copyWith(letterSpacing: 3);

  // ── Material TextTheme mapping ───────────────────────────────
  static TextTheme get textTheme => TextTheme(
        displayLarge: display(fontSize: 56),
        displayMedium: display(fontSize: 36),
        displaySmall: display(fontSize: 32),
        headlineLarge: display(fontSize: 28),
        headlineMedium: display(fontSize: 24),
        headlineSmall: display(fontSize: 19),
        titleLarge: body(
            fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.ink),
        titleMedium: body(
            fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.ink),
        titleSmall: body(
            fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.ink),
        bodyLarge: body(fontSize: 15, color: AppColors.ink2),
        bodyMedium: body(fontSize: 14, color: AppColors.ink2),
        bodySmall: body(fontSize: 12, color: AppColors.ink3),
        labelLarge: body(
            fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.ink),
        labelMedium: body(
            fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.ink3),
        labelSmall: mono(fontSize: 10),
      );
}
