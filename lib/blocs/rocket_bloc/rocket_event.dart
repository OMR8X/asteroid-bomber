part of 'rocket_bloc.dart';

abstract class RocketEvent extends Equatable {
  const RocketEvent();

  @override
  List<Object> get props => [];
}

class RocketPositionChangedEvent extends RocketEvent {
  final Offset position;

  const RocketPositionChangedEvent(this.position);

  @override
  List<Object> get props => [position];
}

class RocketScreenInitializedEvent extends RocketEvent {
  const RocketScreenInitializedEvent();

  @override
  List<Object> get props => [];
}

class BulletFiredEvent extends RocketEvent {
  final Offset startPosition;

  const BulletFiredEvent(this.startPosition);

  @override
  List<Object> get props => [startPosition];
}

class BulletsUpdatedEvent extends RocketEvent {}
