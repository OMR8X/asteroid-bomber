part of 'asteriods_bloc.dart';

class AsteroidsState extends Equatable {
  final List<Asteroid> asteroids;
  const AsteroidsState({required this.asteroids});

  AsteroidsState copyWith({List<Asteroid>? asteriods}) {
    return AsteroidsState(
      asteroids: asteriods ?? this.asteroids,
    );
  }

  @override
  List<Object> get props => [asteroids];
}
