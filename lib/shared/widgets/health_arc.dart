import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../app/theme.dart';

/// Segmented arc showing the percentage of warranty period remaining
/// (Blueprint Section 2.1 "Warranty Health Score").
///
/// Colour bands: green >50%, amber 20–50%, red <20%.
class HealthArc extends StatelessWidget {
  /// Creates a health arc.
  const HealthArc({
    super.key,
    required this.percent,
    this.size = 64,
    this.showLabel = true,
  });

  /// Percentage of warranty remaining (0–100).
  final double percent;

  /// Diameter in logical pixels.
  final double size;

  /// Whether to render the numeric percent in the centre.
  final bool showLabel;

  /// Colour band for a given [percent], readable in [brightness].
  static Color colorFor(double percent,
      [Brightness brightness = Brightness.light]) {
    if (percent > 50) return AppColors.active(brightness);
    if (percent >= 20) return AppColors.warning(brightness);
    return AppColors.critical(brightness);
  }

  @override
  Widget build(BuildContext context) {
    final clamped = percent.clamp(0.0, 100.0);
    return Semantics(
      label: '${clamped.round()}% of warranty remaining',
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: _ArcPainter(
            clamped / 100,
            Theme.of(context).colorScheme.surfaceContainerHighest,
            colorFor(clamped, Theme.of(context).brightness),
          ),
          child: showLabel
              ? Center(
                  child: Text(
                    '${clamped.round()}%',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size * 0.22,
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  _ArcPainter(this.value, this.trackColor, this.color);

  final double value;
  final Color trackColor;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.width * 0.12;
    final center = size.center(Offset.zero);
    final radius = (size.width - stroke) / 2;
    // 270° arc opening at the bottom.
    const startAngle = math.pi * 0.75;
    const sweep = math.pi * 1.5;

    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = trackColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweep,
      false,
      track,
    );

    final progress = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = color;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweep * value,
      false,
      progress,
    );
  }

  @override
  bool shouldRepaint(_ArcPainter old) =>
      old.value != value || old.color != color || old.trackColor != trackColor;
}
