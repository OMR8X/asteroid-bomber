class Asteroid {
  final int id;
  int hp;
  final double speed;
  final int line; // 0 .. 6
  double position;
  final String imagePath;

  Asteroid({
    required this.id,
    required this.hp,
    required this.speed,
    required this.line,
    required this.imagePath,
    this.position = -40.0,
  });
}
