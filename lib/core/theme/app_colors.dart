import 'package:flutter/material.dart';

/// Every color token from the Yaad HTML design system.
/// Maps 1:1 to CSS variables in yaad_complete_design.html
class AppColors {
  AppColors._(); // prevent instantiation

  // ── Core backgrounds ────────────────────────────────────────
  static const Color cream = Color(0xFFFDFCF9); // --cream
  static const Color paper = Color(0xFFFFFFFF); // --paper
  static const Color paperWarm = Color(0xFFFAF6F0); // --paper-warm

  // ── Brand pink ──────────────────────────────────────────────
  static const Color pink = Color(0xFFD4537E); // --pink
  static const Color pinkDeep = Color(0xFFB33960); // --pink-deep
  static const Color pinkSoft = Color(0xFFF2D4DF); // --pink-soft
  static const Color pinkMist = Color(0xFFFBEEF3); // --pink-mist
  static const Color pinkTint = Color(0xFFFDF5F8); // --pink-tint

  // ── Ink (text) — 5 levels ───────────────────────────────────
  static const Color ink = Color(0xFF1C1917); // --ink   (darkest)
  static const Color ink2 = Color(0xFF44403C); // --ink-2
  static const Color ink3 = Color(0xFF78716C); // --ink-3
  static const Color ink4 = Color(0xFFA8A29E); // --ink-4
  static const Color ink5 = Color(0xFFD6D3D0); // --ink-5 (lightest)

  // ── Borders ─────────────────────────────────────────────────
  static const Color border = Color(0xFFEDE8E3); // --border
  static const Color borderSoft = Color(0xFFF5F0EA); // --border-soft

  // ── Category tag colors ─────────────────────────────────────
  // Coral — Work
  static const Color coral = Color(0xFFE08266); // --coral
  static const Color coralBg = Color(0xFFFBE9E1); // --coral-bg

  // Sage — Self
  static const Color sage = Color(0xFF809578); // --sage
  static const Color sageBg = Color(0xFFECF0E8); // --sage-bg

  // Clay — Home
  static const Color clay = Color(0xFFB89160); // --clay
  static const Color clayBg = Color(0xFFF5EBD9); // --clay-bg

  // Dusk — Family / Deen
  static const Color dusk = Color(0xFF9B7BA8); // --dusk
  static const Color duskBg = Color(0xFFF0EAF3); // --dusk-bg

  // ── Semantic helpers ────────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;

  // ── Tag color map — use by category name ────────────────────
  static const Map<String, Color> tagColor = {
    'self': sage,
    'work': dusk,
    'family': coral,
    'deen': pink,
    'home': clay,
  };

  static const Map<String, Color> tagBgColor = {
    'self': sageBg,
    'work': duskBg,
    'family': coralBg,
    'deen': pinkMist,
    'home': clayBg,
  };
}
