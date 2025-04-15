part of 'rocket_bloc.dart';

abstract class RocketEvent extends Equatable {
  const RocketEvent();

  @override
  List<Object> get props => [];
}

class RocketPositionUpdated extends RocketEvent {
  final Offset offset;

  const RocketPositionUpdated(this.offset);

  @override
  List<Object> get props => [offset];
}
