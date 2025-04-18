part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

// Rocket events
class RocketPositionUpdatedEvent extends GameEvent {
  final Offset offset;

  const RocketPositionUpdatedEvent(this.offset);

  @override
  List<Object> get props => [offset];
}

class RocketPositionChangedEvent extends GameEvent {
  final Offset position;

  const RocketPositionChangedEvent(this.position);

  @override
  List<Object> get props => [position];
}

class RocketScreenInitializedEvent extends GameEvent {
  final Size screenSize;

  const RocketScreenInitializedEvent(this.screenSize);

  @override
  List<Object> get props => [screenSize];
}

// Bullet events
class BulletFiredEvent extends GameEvent {
  final Offset startPosition;

  const BulletFiredEvent(this.startPosition);
  
  @override
  List<Object> get props => [startPosition];
}

class BulletsUpdatedEvent extends GameEvent {}

class StartAutoFireEvent extends GameEvent {}

class StopAutoFireEvent extends GameEvent {}