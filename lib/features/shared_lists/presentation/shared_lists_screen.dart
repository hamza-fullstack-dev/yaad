import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/widgets/yaad_loading_skeleton.dart';
import '../../../core/widgets/yaad_error_state.dart';
import '../../auth/data/auth_providers.dart';
import '../../../core/l10n/language_provider.dart';
import '../data/shared_list_providers.dart';
import '../../../core/widgets/yaad_empty_state.dart';
import 'widgets/shared_list_tile.dart';

class SharedListsScreen extends ConsumerWidget {
  const SharedListsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(stringsProvider);
    final listsAsync = ref.watch(userSharedListsProvider);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 16, 22, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.border, width: 0.5),
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        size: 18,
                        color: AppColors.ink,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    s.sharedTitle,
                    style: AppTypography.display(
                      fontSize: 22,
                      color: AppColors.ink,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => _showCreateDialog(context, ref, user?.uid,
                        user?.displayName, user?.email),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.pink,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: listsAsync.when(
                loading: () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: YaadLoadingSkeleton.box(height: 140),
                ),
                error: (e, _) => YaadErrorState(
                  message: s.sharedLoadError,
                  onRetry: () => ref.invalidate(userSharedListsProvider),
                ),
                data: (lists) {
                  if (lists.isEmpty) {
                    return Center(
                      child: YaadEmptyState(
                        title: s.sharedEmptyTitle,
                        subtitle: s.sharedEmptySubtitle,
                        ctaLabel: s.sharedEmptyCta,
                        onCtaTap: () => _showCreateDialog(context, ref,
                            user?.uid, user?.displayName, user?.email),
                      ),
                    );
                  }

                  return ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppRadius.xl),
                          border:
                              Border.all(color: AppColors.border, width: 0.5),
                          boxShadow: AppShadows.sm,
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Column(
                          children: List.generate(lists.length, (i) {
                            return Column(
                              children: [
                                if (i != 0)
                                  Container(
                                    margin: const EdgeInsets.only(left: 68),
                                    height: 0.5,
                                    color: AppColors.border,
                                  ),
                                SharedListTile(
                                  list: lists[i],
                                  onTap: () => context.push(
                                    '/shared-lists/${lists[i].id}',
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateDialog(
    BuildContext context,
    WidgetRef ref,
    String? uid,
    String? displayName,
    String? email,
  ) {
    if (uid == null) return;
    final s = ref.read(stringsProvider);
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          s.sharedNewTitle,
          style: AppTypography.display(fontSize: 19, color: AppColors.ink),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: AppTypography.body(fontSize: 15, color: AppColors.ink),
          decoration: InputDecoration(
            hintText: s.sharedNewHint,
            hintStyle: AppTypography.body(fontSize: 15, color: AppColors.ink4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.pink),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              s.sharedNewCancel,
              style: AppTypography.body(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.ink3,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              final name = controller.text.trim();
              if (name.isEmpty) return;
              Navigator.of(ctx).pop();
              await ref.read(sharedListRepositoryProvider).createList(
                    name: name,
                    ownerId: uid,
                    ownerName: displayName ?? '',
                    ownerEmail: email ?? '',
                  );
            },
            child: Text(
              s.sharedNewCreate,
              style: AppTypography.body(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.pink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
