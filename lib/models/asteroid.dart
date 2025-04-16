import 'package:asteroid_bomber/resources/asteroids_resources.dart';

class Asteroid {
  final int id;
  int hp;
  final double speed;
  final int line; // 0 .. 4
  double position;
  final String imagePath;

  Asteroid({
    required this.id,
    required this.hp,
    required this.speed,
    required this.line,
    required this.imagePath,
    this.position = AsteroidsResources.startPosition,
  });
}
