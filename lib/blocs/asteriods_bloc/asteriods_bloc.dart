import 'dart:math';

import 'package:asteroid_bomber/resources/asteroids_resources.dart';
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
      final int newLine = random.nextInt(AsteroidsResources.maxNoLine);
      final lineAsteroids = state.asteroids.where((a) => a.line == newLine).toList();
      double safeTop = AsteroidsResources.startPosition;
      if (lineAsteroids.isNotEmpty) {
        // to get the most top asteroid in the line
        final topMost = lineAsteroids.reduce((a, b) => a.position < b.position ? a : b);

        // check if top asteroid has some space from top of screen
        if (topMost.position - (300 + AsteroidsResources.startPosition) < AsteroidsResources.startPosition) {
          safeTop = topMost.position - (300 + AsteroidsResources.startPosition);
        }
      }
      final newAsteroid = Asteroid(
        id: _idCounter++,
        hp: 100,
        line: newLine,
        speed: 30 + random.nextDouble() * 6,
        imagePath: "${ImagesResources.asteroidImagePath}${random.nextInt(8) + 1}.png",
        position: safeTop,
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
          .where((a) => a.position < event.screenHeight)
          .toList();

      emit(state.copyWith(asteriods: updated));
    });
    on<DamagedAsteroidEvent>((event, emit) {
      //
    });
  }
}
