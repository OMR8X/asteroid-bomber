import 'package:flutter/material.dart';

class BulletPainter extends CustomPainter {
  final List<Offset> bulletPositions;

  BulletPainter(this.bulletPositions);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.red;

    for (final pos in bulletPositions) {
      final bulletRect = Rect.fromCenter(center: pos, width: 6, height: 12);
      canvas.drawRect(bulletRect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant BulletPainter oldDelegate) {
    return oldDelegate.bulletPositions != bulletPositions;
  }
}
