import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/l10n/language_provider.dart';

// ── Onboarding page data ─────────────────────────────────────────
class _OnbPage {
  final String step;
  final String title;
  final String titleItalic; // the italic word
  final String titleAfter;
  final String desc;
  final String btnLabel;
  final Widget hero;

  const _OnbPage({
    required this.step,
    required this.title,
    required this.titleItalic,
    required this.titleAfter,
    required this.desc,
    required this.btnLabel,
    required this.hero,
  });
}

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<_OnbPage> _buildPages() {
    final s = ref.read(stringsProvider);
    return [
      _OnbPage(
        step: s.onb1Step,
        title: s.onb1Title,
        titleItalic: s.onb1TitleItalic,
        titleAfter: '',
        desc: s.onb1Desc,
        btnLabel: s.onb1Btn,
        hero: Image.asset('assets/onboarding/onboarding_tasks.png',
            width: 200, height: 200),
      ),
      _OnbPage(
        step: s.onb2Step,
        title: s.onb2Title,
        titleItalic: s.onb2TitleItalic,
        titleAfter: s.onb2TitleAfter,
        desc: s.onb2Desc,
        btnLabel: s.onb2Btn,
        hero: Image.asset('assets/onboarding/onboarding_diary.png',
            width: 200, height: 200),
      ),
      _OnbPage(
        step: s.onb3Step,
        title: s.onb3Title,
        titleItalic: s.onb3TitleItalic,
        titleAfter: s.onb3TitleAfter,
        desc: s.onb3Desc,
        btnLabel: s.onb3Btn,
        hero: Image.asset('assets/onboarding/onboarding_privacy.png',
            width: 200, height: 200),
      ),
    ];
  }

  void _next() async {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppConstants.onboardingSeenKey, true);
      if (mounted) context.go(RouteNames.home);
    }
  }

  void _skip() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.onboardingSeenKey, true);
    if (mounted) context.go(RouteNames.home);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = _buildPages();
    final s = ref.watch(stringsProvider);
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: (i) => setState(() => _currentPage = i),
          itemCount: pages.length,
          itemBuilder: (context, index) {
            final page = pages[index];
            return _OnbPageView(
              page: page,
              currentIndex: _currentPage,
              totalPages: pages.length,
              onNext: _next,
              onSkip: _skip,
              skipLabel: s.skip,
            );
          },
        ),
      ),
    );
  }
}

// ── Single onboarding page ───────────────────────────────────────
class _OnbPageView extends StatelessWidget {
  final _OnbPage page;
  final int currentIndex;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final String skipLabel;

  const _OnbPageView({
    required this.page,
    required this.currentIndex,
    required this.totalPages,
    required this.onNext,
    required this.onSkip,
    required this.skipLabel,
  });

  @override
  Widget build(BuildContext context) {
    final isLast = currentIndex == totalPages - 1;

    return Padding(
      // matches .onb { padding: 70px 28px 40px }
      padding: const EdgeInsets.fromLTRB(28, 70, 28, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top row: step counter + skip ────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // .onb-step: DM Mono, 11px, letter-spacing 2px, ink-4, uppercase
              Text(
                page.step,
                style: AppTypography.mono(
                  fontSize: 11,
                  color: AppColors.ink4,
                ).copyWith(letterSpacing: 2),
              ),
              if (!isLast)
                GestureDetector(
                  onTap: onSkip,
                  child: Text(
                    skipLabel,
                    // .onb-skip: 13px, weight 500, ink-3
                    style: AppTypography.body(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.ink3,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 32), // .onb-top margin-bottom: 32px

          // ── Hero illustration — flex: 1, centered ───────────
          Expanded(
            child: Center(child: _FloatingHero(child: page.hero)),
          ),

          const SizedBox(height: 32), // .onb-hero margin-bottom: 32px

          // ── Title: plain + italic(pink) + plain ─────────────
          // .onb-title: DM Serif Display, 36px, line-height 1.1, letter-spacing -0.8px
          // .onb-title em: italic, color pink
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: page.title,
                  style: AppTypography.display(
                    fontSize: 36,
                    color: AppColors.ink,
                  ).copyWith(letterSpacing: -0.8, height: 1.1),
                ),
                TextSpan(
                  text: page.titleItalic,
                  style: AppTypography.displayItalic(
                    fontSize: 36,
                    color: AppColors.pink,
                  ).copyWith(letterSpacing: -0.8, height: 1.1),
                ),
                if (page.titleAfter.isNotEmpty)
                  TextSpan(
                    text: page.titleAfter,
                    style: AppTypography.display(
                      fontSize: 36,
                      color: AppColors.ink,
                    ).copyWith(letterSpacing: -0.8, height: 1.1),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 14), // .onb-title margin-bottom: 14px

          // ── Description ──────────────────────────────────────
          // .onb-desc: 15px, line-height 1.6, ink-3, margin-bottom 32px
          Text(
            page.desc,
            style: AppTypography.body(
              fontSize: 15,
              color: AppColors.ink3,
            ).copyWith(height: 1.6),
          ),

          const SizedBox(height: 32),

          // ── Dots ─────────────────────────────────────────────
          // .onb-dot: 6px circle, ink-5
          // .onb-dot.active: 24px wide pill, pink
          Row(
            children: List.generate(totalPages, (i) {
              final isActive = i == currentIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.only(right: 6),
                width: isActive ? 24 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.pink : AppColors.ink5,
                  borderRadius: BorderRadius.circular(100),
                ),
              );
            }),
          ),

          const SizedBox(height: 20),

          // ── Button ───────────────────────────────────────────
          // .onb-btn.pink: pink bg, shadow-pink, 16px padding, pill, white text 15px 600
          GestureDetector(
            onTap: onNext,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.pink,
                borderRadius: BorderRadius.circular(100),
                boxShadow: AppShadows.pink,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    page.btnLabel,
                    style: AppTypography.body(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ).copyWith(letterSpacing: 0.1),
                  ),
                  if (!isLast) ...[
                    const SizedBox(width: 8),
                    // Arrow icon → matches HTML SVG arrow
                    const _ArrowIcon(),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Arrow icon (matches HTML SVG exactly) ───────────────────────
class _ArrowIcon extends StatelessWidget {
  const _ArrowIcon();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(14, 14),
      painter: _ArrowPainter(),
    );
  }
}

class _FloatingHero extends StatefulWidget {
  final Widget child;
  const _FloatingHero({required this.child});

  @override
  State<_FloatingHero> createState() => _FloatingHeroState();
}

class _FloatingHeroState extends State<_FloatingHero>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _float;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);
    _float = Tween<double>(begin: 0, end: -8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _float,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, _float.value),
        child: child,
      ),
      child: widget.child,
    );
  }
}

class _ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // path: M2 7 H12 M8 3 L12 7 L8 11
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    // Horizontal line
    canvas.drawLine(const Offset(2, 7), const Offset(12, 7), paint);
    // Arrow head
    final path = Path()
      ..moveTo(8, 3)
      ..lineTo(12, 7)
      ..lineTo(8, 11);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ArrowPainter oldDelegate) => false;
}
