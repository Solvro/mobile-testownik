import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radii.dart';
import '../theme/app_shadows.dart';

class SurfaceCard extends StatelessWidget {
  const SurfaceCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = AppRadii.xl,
    this.useGradient = false,
    this.backgroundColor = AppColors.card,
    this.boxShadow = AppShadows.xs,
    this.clipBehavior = Clip.antiAlias,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final bool useGradient;
  final Color backgroundColor;
  final List<BoxShadow> boxShadow;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: clipBehavior,
      padding: padding,
      decoration: BoxDecoration(
        color: useGradient ? null : backgroundColor,
        gradient: useGradient
            ? const RadialGradient(
                center: Alignment.topLeft,
                radius: 1.4,
                colors: [
                  AppColors.cardGradientFrom,
                  AppColors.cardGradientTo,
                ],
              )
            : null,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: AppColors.cardRing),
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
