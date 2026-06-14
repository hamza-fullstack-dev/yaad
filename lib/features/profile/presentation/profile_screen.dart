import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/widgets/yaad_tab_bar.dart';
import '../../../core/l10n/language_provider.dart';
import '../../auth/data/auth_providers.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_stats.dart';
import 'widgets/settings_row.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(stringsProvider);
    final lang = ref.watch(languageProvider);
    final user = ref.watch(currentUserProvider);
    final displayName = user?.displayName ?? 'Yaad User';
    final parts = displayName.split(' ');
    final firstName = parts.first;
    final lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';
    final initial = displayName.isNotEmpty ? displayName[0].toUpperCase() : 'Y';
    final email = user?.email ?? '';

    return Scaffold(
      backgroundColor: AppColors.paper,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.lg,
                AppSpacing.xl,
                100,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => context.go(RouteNames.home),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.arrow_back_ios_new_rounded,
                              size: 16, color: AppColors.ink3),
                          const SizedBox(width: 4),
                          Text(
                            s.back,
                            style: AppTypography.body(
                              fontSize: 14,
                              color: AppColors.ink3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ProfileHeader(
                    initial: initial,
                    firstName: firstName,
                    lastName: lastName,
                    email: email,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const ProfileStats(),
                  const SizedBox(height: AppSpacing.xl),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border, width: 0.5),
                    ),
                    child: Column(
                      children: [
                        SettingsRow(
                          iconBg: AppColors.pinkMist,
                          iconColor: AppColors.pink,
                          iconPainter: AccountIconPainter(),
                          label: s.settAccount,
                          onTap: () => context.push(RouteNames.account),
                        ),
                        _divider(),
                        SettingsRow(
                          iconBg: AppColors.duskBg,
                          iconColor: AppColors.dusk,
                          iconPainter: SharedListsIconPainter(),
                          label: s.settSharedLists,
                          onTap: () => context.push(RouteNames.sharedLists),
                        ),
                        _divider(),
                        SettingsRow(
                          iconBg: AppColors.coralBg,
                          iconColor: AppColors.coral,
                          iconPainter: NotifIconPainter(),
                          label: s.settNotifications,
                          onTap: () =>
                              context.push(RouteNames.notificationSettings),
                        ),
                        _divider(),
                        SettingsRow(
                          iconBg: AppColors.sageBg,
                          iconColor: AppColors.sage,
                          iconPainter: LockIconPainter(),
                          label: s.settPrivacy,
                          onTap: () =>
                              context.push(RouteNames.diaryLockSettings),
                        ),
                        _divider(),
                        SettingsRow(
                          iconBg: AppColors.clayBg,
                          iconColor: AppColors.clay,
                          iconPainter: LanguageIconPainter(),
                          label: s.settLanguage,
                          value:
                              lang == AppLanguage.english ? 'English' : 'Urdu',
                          onTap: () {
                            final notifier =
                                ref.read(languageProvider.notifier);
                            notifier.setLanguage(
                              lang == AppLanguage.english
                                  ? AppLanguage.urdu
                                  : AppLanguage.english,
                            );
                          },
                        ),
                        _divider(),
                        SettingsRow(
                          iconBg: AppColors.duskBg,
                          iconColor: AppColors.dusk,
                          iconPainter: AppearanceIconPainter(),
                          label: s.settAppearance,
                        ),
                        _divider(),
                        SettingsRow(
                          iconBg: AppColors.paperWarm,
                          iconColor: AppColors.ink2,
                          iconPainter: AboutIconPainter(),
                          label: s.settAbout,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: YaadTabBar(activeIndex: 3),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: const EdgeInsets.only(left: 62),
      height: 0.5,
      color: AppColors.border,
    );
  }
}
