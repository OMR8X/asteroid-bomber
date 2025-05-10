import 'package:asteroid_bomber/resources/asteroids_resources.dart';

class Asteroid {
  final int id;
  int hp;
  final double speed;
  final int line; // 0 .. 4
  double position;
  final String imagePath;
  final bool isExploding;
  final DateTime? explosionStartTime;

  Asteroid({
    required this.id,
    required this.hp,
    required this.speed,
    required this.line,
    required this.imagePath,
    this.position = AsteroidsResources.startPosition,
    required this.isExploding,
    this.explosionStartTime,
  });

  Asteroid copyWith({
    int? id,
    int? line,
    double? speed,
    int? hp,
    String? imagePath,
    double? position,
    bool? isExploding,
    DateTime? explosionStartTime,
  }) {
    return Asteroid(
      id: id ?? this.id,
      line: line ?? this.line,
      speed: speed ?? this.speed,
      hp: hp ?? this.hp,
      imagePath: imagePath ?? this.imagePath,
      position: position ?? this.position,
      isExploding: isExploding ?? this.isExploding,
      explosionStartTime: explosionStartTime ?? this.explosionStartTime,
    );
  }
}
