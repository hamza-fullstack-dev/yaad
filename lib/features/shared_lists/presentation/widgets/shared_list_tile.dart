import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/shared_list_model.dart';

class SharedListTile extends StatelessWidget {
  final SharedList list;
  final VoidCallback? onTap;

  const SharedListTile({super.key, required this.list, this.onTap});

  @override
  Widget build(BuildContext context) {
    final memberCount = list.collaboratorIds.length;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.duskBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  list.name.isNotEmpty ? list.name[0].toUpperCase() : '?',
                  style: AppTypography.display(
                    fontSize: 18,
                    color: AppColors.dusk,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    list.name,
                    style: AppTypography.body(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w500,
                      color: AppColors.ink,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$memberCount ${memberCount == 1 ? 'member' : 'members'} · ${list.ownerName}',
                    style: AppTypography.body(
                      fontSize: 12,
                      color: AppColors.ink4,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: AppColors.ink5,
            ),
          ],
        ),
      ),
    );
  }
}
