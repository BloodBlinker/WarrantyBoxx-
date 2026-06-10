import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../app/theme.dart';

/// Animated ring showing the ratio of active to total non-claimed warranties
/// (Blueprint Section 2.1 "Warranty Health Ring").
///
/// Honours the system "reduce animations" setting (Section 6.3).
class HealthRing extends StatelessWidget {
  /// Creates a health ring.
  const HealthRing({
    super.key,
    required this.ratio,
    required this.centerLabel,
    required this.subLabel,
    this.size = 120,
  });

  /// Active-to-total ratio, 0–1.
  final double ratio;

  /// Large value shown in the centre (e.g. "75%").
  final String centerLabel;

  /// Small caption beneath the centre value.
  final String subLabel;

  /// Diameter in logical pixels.
  final double size;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    final clamped = ratio.clamp(0.0, 1.0);

    return Semantics(
      label: '$centerLabel $subLabel',
      child: SizedBox(
        width: size,
        height: size,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: reduceMotion ? clamped : 0, end: clamped),
          duration: reduceMotion
              ? Duration.zero
              : const Duration(milliseconds: 900),
          curve: Curves.easeOutCubic,
          builder: (context, value, _) => CustomPaint(
            painter: _RingPainter(
              value,
              Theme.of(context).colorScheme.surfaceContainerHighest,
              AppColors.active(Theme.of(context).brightness),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    centerLabel,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    subLabel,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter(this.value, this.trackColor, this.progressColor);

  final double value;
  final Color trackColor;
  final Color progressColor;

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 12.0;
    final center = size.center(Offset.zero);
    final radius = (size.width - stroke) / 2;

    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = trackColor;
    canvas.drawCircle(center, radius, track);

    final progress = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = progressColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * value,
      false,
      progress,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.value != value ||
      old.progressColor != progressColor ||
      old.trackColor != trackColor;
}
