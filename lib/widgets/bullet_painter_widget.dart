import 'package:flutter/material.dart';

class BulletPainter extends CustomPainter {
  final List<Offset> bulletPositions;

  BulletPainter(this.bulletPositions);

  @override
  void paint(Canvas canvas, Size size) {
    for (final pos in bulletPositions) {
      final bulletWidth = 6.0;
      final bulletHeight = 18.0;

      final bulletRect = Rect.fromCenter(
        center: pos,
        width: bulletWidth,
        height: bulletHeight,
      );

      final rRect =
          RRect.fromRectAndRadius(bulletRect, const Radius.circular(6));

      final gradientPaint = Paint()
        ..shader = const LinearGradient(
          colors: [
            Colors.white,
            Colors.cyanAccent,
            Colors.cyan,
            Colors.blue,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(bulletRect);

      final softGlow = Paint()
        ..color = Colors.cyan.withOpacity(0.25)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

      final strongGlow = Paint()
        ..color = Colors.cyanAccent.withOpacity(0.5)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

      final trailRect = Rect.fromCenter(
        center: pos.translate(0, 12),
        width: bulletWidth / 2,
        height: bulletHeight,
      );

      final trailPaint = Paint()
        ..shader = const LinearGradient(
          colors: [
            Colors.cyanAccent,
            Colors.transparent,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(trailRect);

      final trailRRect =
          RRect.fromRectAndRadius(trailRect, const Radius.circular(4));

      canvas.drawRRect(rRect.inflate(6), softGlow);
      canvas.drawRRect(rRect.inflate(2), strongGlow);
      canvas.drawRRect(trailRRect, trailPaint);
      canvas.drawRRect(rRect, gradientPaint);
    }
  }

  @override
  bool shouldRepaint(covariant BulletPainter oldDelegate) {
    return oldDelegate.bulletPositions != bulletPositions;
  }
}
