import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/home_theme.dart';
import 'package:flutter/material.dart';

class HomeLogo extends StatefulWidget {
  const HomeLogo({super.key});

  @override
  State<HomeLogo> createState() => _HomeLogoState();
}

class _HomeLogoState extends State<HomeLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;
    final isTablet = width >= 768 && width < 1200;
    final frameSize = isMobile ? 148.0 : (isTablet ? 250.0 : 290.0);
    final ringLarge = isMobile ? 134.0 : (isTablet ? 188.0 : 216.0);
    final ringMedium = isMobile ? 92.0 : (isTablet ? 126.0 : 146.0);
    final centerIcon = isMobile ? 44.0 : (isTablet ? 64.0 : 74.0);

    return Center(
      child: SizedBox(
        width: frameSize,
        height: frameSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black.withValues(alpha: 0.08),
                ),
              ),
            ),
            Container(
              width: ringLarge,
              height: ringLarge,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black.withValues(alpha: 0.07),
                ),
              ),
            ),
            Container(
              width: ringMedium,
              height: ringMedium,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: HomeTheme.primary.withValues(alpha: 0.25),
                ),
              ),
            ),
            Icon(
              Icons.blur_on,
              size: centerIcon,
              color: HomeTheme.primary,
            ),
            Positioned(
              top: isMobile ? 18 : 32,
              left: isMobile ? 20 : 40,
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (context, _) {
                  final scale = 0.8 + (_pulseController.value * 0.35);
                  final opacity = 0.35 + (_pulseController.value * 0.5);
                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: HomeTheme.primary.withValues(alpha: opacity),
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: isMobile ? 24 : 48,
              right: isMobile ? 20 : 36,
              child: Container(
                width: isMobile ? 9 : 14,
                height: isMobile ? 9 : 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withValues(alpha: 0.10),
                ),
              ),
            ),
            Positioned(
              top: isMobile ? 84 : 144,
              right: isMobile ? 10 : 16,
              child: Container(
                width: isMobile ? 5 : 8,
                height: isMobile ? 5 : 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: HomeTheme.primary.withValues(alpha: 0.45),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
