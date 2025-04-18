part of 'asteriods_bloc.dart';

sealed class AsteroidsEvent extends Equatable {
  const AsteroidsEvent();

  @override
  List<Object> get props => [];
}

class AddAsteroidEvent extends AsteroidsEvent {}

class UpdateAsteroidEvent extends AsteroidsEvent {
  final double screenHeight;

  const UpdateAsteroidEvent({required this.screenHeight});

  @override
  List<Object> get props => [screenHeight];
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
