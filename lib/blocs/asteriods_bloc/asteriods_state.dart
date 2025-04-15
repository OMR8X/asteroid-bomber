part of 'asteriods_bloc.dart';

class AsteriodsState extends Equatable {
  final List<Asteroid> asteroids;
  const AsteriodsState({required this.asteroids});

  AsteriodsState copyWith({List<Asteroid>? asteriods}) {
    return AsteriodsState(
      asteroids: asteriods ?? this.asteroids,
    );
  }

  @override
  List<Object> get props => [asteroids];
}
