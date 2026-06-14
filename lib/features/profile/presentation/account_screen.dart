import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/routing/route_names.dart';
import '../../auth/data/auth_providers.dart';
import '../../auth/presentation/controllers/auth_controller.dart';
import '../../../core/l10n/language_provider.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(stringsProvider);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.lg,
            AppSpacing.xl,
            40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => context.pop(),
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
              const SizedBox(height: AppSpacing.xl),
              Text(
                s.accountTitle,
                style: AppTypography.displayItalic(
                  fontSize: 28,
                  color: AppColors.ink,
                ).copyWith(letterSpacing: -0.5),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.displayName ?? 'Yaad User',
                      style: AppTypography.display(
                        fontSize: 20,
                        color: AppColors.ink,
                      ).copyWith(letterSpacing: -0.3),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user?.email ?? '',
                      style: AppTypography.body(
                        fontSize: 13,
                        color: AppColors.ink4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              GestureDetector(
                onTap: () async {
                  await ref.read(authControllerProvider.notifier).signOut();
                  if (context.mounted) {
                    context.go(RouteNames.signIn);
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border, width: 0.5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.coralBg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.logout_rounded,
                          color: AppColors.coral,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        s.signOut,
                        style: AppTypography.body(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.ink,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Center(
                child: GestureDetector(
                  onTap: () => _confirmDelete(context, ref),
                  child: Text(
                    s.deleteAccountLink,
                    style: AppTypography.body(
                      fontSize: 13,
                      color: Colors.red,
                    ).copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    final s = ref.read(stringsProvider);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          s.deleteAccountTitle,
          style: AppTypography.display(fontSize: 18, color: AppColors.ink),
        ),
        content: Text(
          s.deleteAccountBody,
          style: AppTypography.body(fontSize: 14, color: AppColors.ink3),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              s.no,
              style: AppTypography.body(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.ink3,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(authControllerProvider.notifier).deleteAccount();
              if (context.mounted) {
                context.go(RouteNames.signIn);
              }
            },
            child: Text(
              s.deleteAccountConfirm,
              style: AppTypography.body(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
