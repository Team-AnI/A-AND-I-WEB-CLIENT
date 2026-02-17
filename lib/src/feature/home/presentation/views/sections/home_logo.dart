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
    return Expanded(
      flex: 9,
      child: AspectRatio(
        aspectRatio: 1,
        child: Center(
          child: SizedBox(
            width: 290,
            height: 290,
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
                  width: 216,
                  height: 216,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black.withValues(alpha: 0.07),
                    ),
                  ),
                ),
                Container(
                  width: 146,
                  height: 146,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: HomeTheme.primary.withValues(alpha: 0.25),
                    ),
                  ),
                ),
                const Icon(
                  Icons.blur_on,
                  size: 74,
                  color: HomeTheme.primary,
                ),
                Positioned(
                  top: 32,
                  left: 40,
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
                  bottom: 48,
                  right: 36,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withValues(alpha: 0.10),
                    ),
                  ),
                ),
                Positioned(
                  top: 144,
                  right: 16,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: HomeTheme.primary.withValues(alpha: 0.45),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
