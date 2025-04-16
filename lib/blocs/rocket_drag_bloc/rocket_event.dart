part of 'rocket_bloc.dart';

abstract class RocketEvent extends Equatable {
  const RocketEvent();

  @override
  List<Object> get props => [];
}

class RocketPositionUpdatedEvent extends RocketEvent {
  final Offset offset;

  const RocketPositionUpdatedEvent(this.offset);

  @override
  List<Object> get props => [offset];
}

class RocketPositionChangedEvent extends RocketEvent {
  final Offset position;

  const RocketPositionChangedEvent(this.position);

  @override
  List<Object> get props => [position];
}

class RocketScreenInitializedEvent extends RocketEvent {
  final Size screenSize;

  const RocketScreenInitializedEvent(this.screenSize);

  @override
  List<Object> get props => [screenSize];
}
