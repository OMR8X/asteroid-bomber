import 'dart:ui';

class BulletModel {
  final String imageUrl;
  final Offset position;

  BulletModel({required this.imageUrl, required this.position});

  BulletModel copyWith({Offset? position}) {
    return BulletModel(
      imageUrl: imageUrl,
      position: position ?? this.position,
    );
  }
}
