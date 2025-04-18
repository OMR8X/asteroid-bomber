part of 'rocket_bloc.dart';

class RocketState extends Equatable {
  final Offset rocketPosition;
  final double lowerBoundY;
  final List<BulletModel> bullets;

  const RocketState({
    required this.rocketPosition,
    required this.lowerBoundY,
    required this.bullets,
  });

  factory RocketState.initial() {
    return const RocketState(
      rocketPosition: Offset.zero,
      lowerBoundY: 0,
      bullets: [],
    );
  }

  RocketState copyWith({
    Offset? rocketPosition,
    double? lowerBoundY,
    List<BulletModel>? bullets,
  }) {
    return RocketState(
      rocketPosition: rocketPosition ?? this.rocketPosition,
      lowerBoundY: lowerBoundY ?? this.lowerBoundY,
      bullets: bullets ?? this.bullets,
    );
  }

  @override
  List<Object> get props => [rocketPosition,  lowerBoundY, bullets];
}
