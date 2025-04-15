part of 'asteriods_bloc.dart';

sealed class AsteroidsEvent extends Equatable {
  const AsteroidsEvent();

  @override
  List<Object> get props => [];
}

class AddAsteroidEvent extends AsteroidsEvent {}

class UpdateAsteroidEvent extends AsteroidsEvent {
  final double screenHeight;

  UpdateAsteroidEvent({required this.screenHeight});

  @override
  List<Object> get props => [screenHeight];
}

class DamagedAsteroidEvent extends AsteroidsEvent {}
