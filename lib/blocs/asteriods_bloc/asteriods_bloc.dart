import 'dart:math';

import 'package:asteroid_bomber/resources/images_resources.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/asteroid.dart';

part 'asteriods_event.dart';
part 'asteriods_state.dart';

class AsteroidsBloc extends Bloc<AsteroidsEvent, AsteroidsState> {
  int _idCounter = 0;
  AsteroidsBloc() : super(AsteroidsState(asteroids: [])) {
    on<AddAsteroidEvent>((event, emit) {
      //
      final random = Random();
      final newAsteroid = Asteroid(
        id: _idCounter++,
        hp: 100,
        line: random.nextInt(7),
        speed: 5 + random.nextDouble() * 6,
        imagePath: "${ImagesResources.asteroidImagePath}${random.nextInt(8) + 1}.png",
      );
      emit(AsteroidsState(asteroids: [...state.asteroids, newAsteroid]));
    });
    on<UpdateAsteroidEvent>((event, emit) {
      final updated = state.asteroids
          .map((asteroid) => Asteroid(
                id: asteroid.id,
                line: asteroid.line,
                speed: asteroid.speed,
                hp: asteroid.hp,
                imagePath: asteroid.imagePath,
                position: asteroid.position + asteroid.speed,
              ))
          .where((a) => a.position < 600) // مثلاً 600
          .toList();

      emit(state.copyWith(asteriods: updated));
    });
    on<DamagedAsteroidEvent>((event, emit) {
      //
    });
  }
}
