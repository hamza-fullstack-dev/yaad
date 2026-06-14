import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/l10n/language_provider.dart';
import 'controllers/auth_controller.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    ref.read(authControllerProvider.notifier).clearError();
    await ref.read(authControllerProvider.notifier).signInWithEmail(
          _emailController.text.trim(),
          _passwordController.text,
        );
  }

  Future<void> _googleSignIn() async {
    ref.read(authControllerProvider.notifier).clearError();
    await ref.read(authControllerProvider.notifier).signInWithGoogle();
  }

  void _forgotPassword() {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ref.read(authControllerProvider.notifier).clearError();
      return;
    }
    ref.read(authControllerProvider.notifier).sendPasswordReset(email).then(
      (sent) {
        if (sent && mounted) {
          final s = ref.read(stringsProvider);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(s.resetLinkSent),
              backgroundColor: AppColors.sage,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final s = ref.watch(stringsProvider);

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(28, 48, 28, 40),
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: Center(
                  child: Text(
                    'y',
                    style: AppTypography.displayItalic(
                      fontSize: 36,
                      color: AppColors.pink,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                s.signInTitle,
                style: AppTypography.display(
                  fontSize: 28,
                  color: AppColors.ink,
                ).copyWith(letterSpacing: -0.5),
              ),
              const SizedBox(height: 6),
              Text(
                s.signInSubtitle,
                style: AppTypography.displayItalic(
                  fontSize: 16,
                  color: AppColors.ink3,
                ),
              ),
              const SizedBox(height: 40),
              _InputField(
                controller: _emailController,
                hint: s.emailHint,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              _InputField(
                controller: _passwordController,
                hint: s.passwordHint,
                obscure: _obscurePassword,
                suffix: GestureDetector(
                  onTap: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  child: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20,
                    color: AppColors.ink4,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: _forgotPassword,
                  child: Text(
                    s.forgotPassword,
                    style: AppTypography.body(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.pink,
                    ),
                  ),
                ),
              ),
              if (authState.errorMessage != null) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.coralBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    authState.errorMessage!,
                    style: AppTypography.body(
                      fontSize: 13,
                      color: AppColors.coral,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: GestureDetector(
                  onTap: authState.isLoading ? null : _signIn,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.pink,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: authState.isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              s.signInButton,
                              style: AppTypography.body(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: GestureDetector(
                  onTap: authState.isLoading ? null : _googleSignIn,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: AppColors.border, width: 0.5),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'G',
                            style: AppTypography.display(
                              fontSize: 20,
                              color: AppColors.ink,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            s.googleSignIn,
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
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${s.newHere} ',
                    style: AppTypography.body(
                      fontSize: 14,
                      color: AppColors.ink3,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.go(RouteNames.signUp),
                    child: Text(
                      s.createAccount,
                      style: AppTypography.body(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.pink,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final Widget? suffix;
  final TextInputType? keyboardType;

  const _InputField({
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.suffix,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: AppTypography.body(fontSize: 15, color: AppColors.ink),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTypography.body(fontSize: 15, color: AppColors.ink4),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          suffixIcon: suffix != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: suffix,
                )
              : null,
          suffixIconConstraints:
              const BoxConstraints(maxHeight: 24, maxWidth: 36),
        ),
      ),
    );
  }
}
