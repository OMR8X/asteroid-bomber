part of 'asteriods_bloc.dart';

sealed class AsteroidsEvent extends Equatable {
  const AsteroidsEvent();

  @override
  List<Object> get props => [];
}

class AddAsteroidEvent extends AsteroidsEvent {

  const AddAsteroidEvent();
}

class UpdateAsteroidEvent extends AsteroidsEvent {
  const UpdateAsteroidEvent();

  @override
  List<Object> get props => [];
}

class DamagedAsteroidEvent extends AsteroidsEvent {
  final Offset ship;
  final List<Offset> shoot;

  const DamagedAsteroidEvent({
    required this.ship,
    required this.shoot,
  });

  @override
  List<Object> get props => [ shoot];
}
