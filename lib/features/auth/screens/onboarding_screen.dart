import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samriddhi_algo_trade_app/core/constants/app_images.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _next() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  void _finish() {
    context.go(AppRoutes.login);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // App Logo
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 120.0),
              child: Image.asset(AppImages.appLogo, height: 150),
            ),
          ),

          //Main Content
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (_, i) => _OnboardPageView(page: _pages[i]),
          ),

          // Bottom Controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 50),
              child: Row(
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _pages.length,
                    effect: WormEffect(
                      activeDotColor: _pages[_currentPage].accentColor,
                      dotColor: AppColors.border,
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 6,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: _finish,
                    child: Text(
                      'Skip',
                      style: GoogleFonts.spaceGrotesk(
                        color: AppColors.textMuted,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _next,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: _pages[_currentPage].accentColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _currentPage == _pages.length - 1
                                ? 'Get Started'
                                : 'Next',
                            style: GoogleFonts.spaceGrotesk(
                              color: AppColors.textOnPrimary,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: AppColors.textOnPrimary,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardPageView extends StatelessWidget {
  final _OnboardPage page;
  const _OnboardPageView({required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: page.accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: page.accentColor.withValues(alpha: 0.3),
              ),
            ),
            child: Center(
              child: Text(page.emoji, style: const TextStyle(fontSize: 36)),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            page.title,
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.textPrimary,
              fontSize: 34,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            page.subtitle,
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.textSecondary,
              fontSize: 16,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 36),
          ...page.points.map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: page.accentColor.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check, color: page.accentColor, size: 13),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    point,
                    style: GoogleFonts.spaceGrotesk(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardPage {
  final String emoji;
  final String title;
  final String subtitle;
  final Color accentColor;
  final List<String> points;

  const _OnboardPage({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.points,
  });
}

final _pages = [
  const _OnboardPage(
    emoji: '🤖',
    title: 'Automate Your Trading',
    subtitle:
        'Deploy rule-based strategies that execute automatically through your broker account.',
    accentColor: AppColors.primary,
    points: [
      'No coding required',
      'Works 24/5 for you',
      'Emotion-free execution',
    ],
  ),
  const _OnboardPage(
    emoji: '📊',
    title: 'Track Live Performance',
    subtitle:
        'Monitor your P&L, open positions, and strategy performance in real time.',
    accentColor: AppColors.info,
    points: [
      'Live position tracking',
      'Day & overall P&L',
      'Strategy analytics',
    ],
  ),
  const _OnboardPage(
    emoji: '🛡️',
    title: 'You Stay In Control',
    subtitle:
        'Enable/disable strategies, set risk limits, and override anytime. Your capital, your rules.',
    accentColor: AppColors.warning,
    points: [
      'Instant pause/resume',
      'Capital protection',
      'Secure API connection',
    ],
  ),
];
