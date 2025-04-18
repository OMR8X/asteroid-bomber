part of 'game_bloc.dart';

class GameState extends Equatable {
  final Offset rocketPosition;
  final Size screenSize;
  final double lowerBoundY;
  final List<BulletModel> bullets;

  const GameState({
    required this.rocketPosition,
    required this.screenSize,
    required this.lowerBoundY,
    required this.bullets,
  });

  factory GameState.initial() {
    return const GameState(
      rocketPosition: Offset.zero,
      screenSize: Size.zero,
      lowerBoundY: 0,
      bullets: [],
    );
  }

  GameState copyWith({
    Offset? rocketPosition,
    Size? screenSize,
    double? lowerBoundY,
    List<BulletModel>? bullets,
  }) {
    return GameState(
      rocketPosition: rocketPosition ?? this.rocketPosition,
      screenSize: screenSize ?? this.screenSize,
      lowerBoundY: lowerBoundY ?? this.lowerBoundY,
      bullets: bullets ?? this.bullets,
    );
  }

  @override
  List<Object> get props => [rocketPosition, screenSize, lowerBoundY, bullets];
}