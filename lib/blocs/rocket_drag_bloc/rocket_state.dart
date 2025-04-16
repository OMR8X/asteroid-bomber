part of 'rocket_bloc.dart';

class RocketState extends Equatable {
  final Offset position;
  final Size screenSize;
  final double lowerBoundY;

  const RocketState({
    required this.position,
    required this.screenSize,
    required this.lowerBoundY,
  });

  factory RocketState.initial() {
    return const RocketState(
      position: Offset.zero,
      screenSize: Size.zero,
      lowerBoundY: 0,
    );
  }

  RocketState copyWith({
    Offset? position,
    Size? screenSize,
    double? lowerBoundY,
  }) {
    return RocketState(
      position: position ?? this.position,
      screenSize: screenSize ?? this.screenSize,
      lowerBoundY: lowerBoundY ?? this.lowerBoundY,
    );
  }

  @override
  List<Object> get props => [position, screenSize, lowerBoundY];
}
