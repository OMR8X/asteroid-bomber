import 'dart:ui';

class BulletModel {
  final Offset position;

  BulletModel({required this.position});

  BulletModel copyWith({Offset? position}) {
    return BulletModel(
      position: position ?? this.position,
    );
  }
}
