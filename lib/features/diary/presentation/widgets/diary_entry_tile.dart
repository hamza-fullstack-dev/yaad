import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class DiaryEntryData {
  final String day;
  final String weekday;
  final String title;
  final String snippet;
  final String mood;
  final Color moodColor;

  const DiaryEntryData({
    required this.day,
    required this.weekday,
    required this.title,
    required this.snippet,
    required this.mood,
    required this.moodColor,
  });
}

class DiaryEntryTile extends StatelessWidget {
  final DiaryEntryData entry;
  final VoidCallback? onTap;

  const DiaryEntryTile({
    super.key,
    required this.entry,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // .diary-entry: white, 16px radius, border, padding 16px
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Date column ──────────────────────────────────
            // .diary-entry-date: column, align center, width 36px
            SizedBox(
              width: 36,
              child: Column(
                children: [
                  // .diary-entry-day: DM Serif italic 22px pink
                  Text(
                    entry.day,
                    style: AppTypography.displayItalic(
                      fontSize: 22,
                      color: AppColors.pink,
                    ).copyWith(letterSpacing: -0.5, height: 1),
                  ),
                  const SizedBox(height: 2),
                  // .diary-entry-weekday: DM Mono 10px ink-4
                  Text(
                    entry.weekday,
                    style: AppTypography.mono(
                      fontSize: 10,
                      color: AppColors.ink4,
                    ).copyWith(letterSpacing: 0.3),
                  ),
                ],
              ),
            ),

            // ── Divider ──────────────────────────────────────
            Container(
              width: 0.5,
              height: 70,
              color: AppColors.border,
              margin: const EdgeInsets.symmetric(horizontal: 14),
            ),

            // ── Entry body ───────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // .diary-entry-title: 14px weight 500 ink
                  Text(
                    entry.title,
                    style: AppTypography.body(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.ink,
                    ).copyWith(letterSpacing: -0.1),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  // .diary-entry-snippet: 12px ink-3 line-height 1.5
                  Text(
                    entry.snippet,
                    style: AppTypography.body(
                      fontSize: 12,
                      color: AppColors.ink3,
                    ).copyWith(height: 1.5),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  // .diary-entry-mood: mood dot + label
                  Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: entry.moodColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        entry.mood,
                        style: AppTypography.body(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: entry.moodColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
