import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_radius.dart';
import '../data/shared_list_providers.dart';
import '../../../core/l10n/language_provider.dart';

class InviteScreen extends ConsumerStatefulWidget {
  final String listId;

  const InviteScreen({super.key, required this.listId});

  @override
  ConsumerState<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends ConsumerState<InviteScreen> {
  late final String _inviteLink;

  @override
  void initState() {
    super.initState();
    _inviteLink = 'yaad://invite/${widget.listId}';
  }

  void _copyLink() {
    Clipboard.setData(ClipboardData(text: _inviteLink));
    final s = ref.read(stringsProvider);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          s.inviteLinkCopied,
          style: AppTypography.body(fontSize: 13, color: Colors.white),
        ),
        backgroundColor: AppColors.sage,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(stringsProvider);
    final membersAsync = ref.watch(sharedListMembersProvider(widget.listId));

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
                    s.inviteTitle,
                    style: AppTypography.display(
                      fontSize: 22,
                      color: AppColors.ink,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  border: Border.all(color: AppColors.border, width: 0.5),
                  boxShadow: AppShadows.sm,
                ),
                child: Column(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.duskBg,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.link_rounded,
                        color: AppColors.dusk,
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      s.inviteLinkSection,
                      style: AppTypography.body(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      s.inviteLinkDesc,
                      style: AppTypography.body(
                          fontSize: 13, color: AppColors.ink3),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.paperWarm,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.border, width: 0.5),
                      ),
                      child: Text(
                        _inviteLink,
                        style: AppTypography.mono(
                            fontSize: 12, color: AppColors.ink3),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 14),
                    GestureDetector(
                      onTap: _copyLink,
                      child: Container(
                        width: double.infinity,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.pink,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Text(
                            s.inviteCopyLink,
                            style: AppTypography.body(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  s.inviteMembersSection,
                  style: AppTypography.body(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: membersAsync.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.pink,
                    strokeWidth: 2,
                  ),
                ),
                error: (_, __) => Center(
                  child: Text(
                    s.inviteMembersError,
                    style:
                        AppTypography.body(fontSize: 14, color: AppColors.ink3),
                  ),
                ),
                data: (members) {
                  if (members.isEmpty) {
                    return Center(
                      child: Text(
                        s.inviteOnlyYou,
                        style: AppTypography.body(
                            fontSize: 14, color: AppColors.ink4),
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
                          children: List.generate(members.length, (i) {
                            final m = members[i];
                            return Column(
                              children: [
                                if (i != 0)
                                  Container(
                                    margin: const EdgeInsets.only(left: 60),
                                    height: 0.5,
                                    color: AppColors.border,
                                  ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 34,
                                        height: 34,
                                        decoration: BoxDecoration(
                                          color: AppColors.pinkMist,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            m.displayName.isNotEmpty
                                                ? m.displayName[0].toUpperCase()
                                                : '?',
                                            style: AppTypography.body(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.pinkDeep,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              m.displayName.isNotEmpty
                                                  ? m.displayName
                                                  : m.email,
                                              style: AppTypography.body(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.ink,
                                              ),
                                            ),
                                            Text(
                                              m.role.name,
                                              style: AppTypography.body(
                                                fontSize: 11,
                                                color: AppColors.ink4,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
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
}
