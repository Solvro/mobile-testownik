import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class GradientScaffoldBackground extends StatelessWidget {
  const GradientScaffoldBackground({
    super.key,
    required this.child,
    this.isRadialHero = false,
  });

  final Widget child;
  final bool isRadialHero;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (isRadialHero)
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0, -1),
                    radius: 1.15,
                    colors: [
                      AppColors.backgroundGradientFrom.withValues(alpha: 0.55),
                      AppColors.background.withValues(alpha: 0),
                    ],
                    stops: const [0, 0.7],
                  ),
                ),
              ),
            )
          else
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: 110,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.backgroundGradientFrom.withValues(alpha: 0.5),
                      AppColors.background.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
          child,
        ],
      ),
    );
  }
}
