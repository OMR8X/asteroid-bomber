part of 'game_bloc.dart';

class RocketState extends Equatable {
  final Offset rocketPosition;
  final Size screenSize;
  final double lowerBoundY;
  final List<BulletModel> bullets;

  const RocketState({
    required this.rocketPosition,
    required this.screenSize,
    required this.lowerBoundY,
    required this.bullets,
  });

  factory RocketState.initial() {
    return const RocketState(
      rocketPosition: Offset.zero,
      screenSize: Size.zero,
      lowerBoundY: 0,
      bullets: [],
    );
  }

  RocketState copyWith({
    Offset? rocketPosition,
    Size? screenSize,
    double? lowerBoundY,
    List<BulletModel>? bullets,
  }) {
    return RocketState(
      rocketPosition: rocketPosition ?? this.rocketPosition,
      screenSize: screenSize ?? this.screenSize,
      lowerBoundY: lowerBoundY ?? this.lowerBoundY,
      bullets: bullets ?? this.bullets,
    );
  }

  @override
  List<Object> get props => [rocketPosition, screenSize, lowerBoundY, bullets];
}
