import 'dart:ui';

class BulletModel {
  final Offset position;
  final bool isExploding;
  final DateTime? explosionStartTime;

  BulletModel({
    required this.position,
    required this.isExploding,
    this.explosionStartTime,
  });

  BulletModel copyWith({
    Offset? position,
    bool? isExploding,
    DateTime? explosionStartTime,
  }) {
    return BulletModel(
      position: position ?? this.position,
      isExploding: isExploding ?? this.isExploding,
      explosionStartTime: explosionStartTime ?? this.explosionStartTime,
    );
  }
}
