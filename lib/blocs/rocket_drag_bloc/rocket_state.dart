part of 'rocket_bloc.dart';

class RocketState extends Equatable {
  final Offset position;

  const RocketState({required this.position});

  factory RocketState.initial() {
    return const RocketState(position: Offset(100.0, 100.0));
  }

  RocketState copyWith({
    Offset? position,
  }) {
    return RocketState(
      position: position ?? this.position,
    );
  }

  @override
  List<Object> get props => [position];
}
