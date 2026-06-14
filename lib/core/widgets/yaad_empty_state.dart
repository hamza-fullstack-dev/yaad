import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class YaadEmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? ctaLabel;
  final VoidCallback? onCtaTap;
  final Widget? illustration;

  const YaadEmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    this.ctaLabel,
    this.onCtaTap,
    this.illustration,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$title. $subtitle',
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (illustration != null) ...[
              SizedBox(width: 60, height: 60, child: illustration),
              const SizedBox(height: 20),
            ],
            Text(
              title,
              style: AppTypography.displayItalic(
                fontSize: 22,
                color: AppColors.ink,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                subtitle,
                style: AppTypography.body(
                  fontSize: 14,
                  color: AppColors.ink3,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (ctaLabel != null && onCtaTap != null) ...[
              const SizedBox(height: 20),
              GestureDetector(
                onTap: onCtaTap,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
                  decoration: BoxDecoration(
                    color: AppColors.pink,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    ctaLabel!,
                    style: AppTypography.body(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
