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
  final List<Asteroid> asteroid;
  final List<Offset> shoot;
  final double screenWidth;

  const DamagedAsteroidEvent({
    required this.asteroid,
    required this.shoot,
    required this.screenWidth,
  });

  @override
  List<Object> get props => [asteroid, shoot, screenWidth];
}
