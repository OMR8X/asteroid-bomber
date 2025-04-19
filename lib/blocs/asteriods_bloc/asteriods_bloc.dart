import 'dart:math';
import 'package:asteroid_bomber/models/screen_size.dart';
import 'package:asteroid_bomber/resources/asteroids_resources.dart';
import 'package:asteroid_bomber/resources/images_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../injection/app_inj.dart';
import '../../models/asteroid.dart';

part 'asteriods_event.dart';
part 'asteriods_state.dart';

class AsteroidsBloc extends Bloc<AsteroidsEvent, AsteroidsState> {
  int _idCounter = 0;
  AsteroidsBloc() : super(AsteroidsState(asteroids: [])) {
    on<AddAsteroidEvent>((event, emit) {
      //
      final random = Random();
      final int newLine = random.nextInt(AsteroidsResources.maxNoLine) + 1;
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
      int imgPathNum = random.nextInt(8) + 1;
      int asteroidSize = imgPathNum % 2 + 1;
      final newAsteroid = Asteroid(
        id: _idCounter++,
        hp: 100 * asteroidSize,
        line: newLine,
        speed: 1 + (2 / asteroidSize),
        imagePath: "${ImagesResources.asteroidImagePath}$imgPathNum.png",
        position: safeTop,
        isExploding: false,
      );
      emit(AsteroidsState(asteroids: [...state.asteroids, newAsteroid]));
    });
    on<UpdateAsteroidEvent>((event, emit) {
      if (Random().nextInt(100) < (100 - state.asteroids.length * (100 / AsteroidsResources.maxNoAsteroids))) {
        sl<AsteroidsBloc>().add(AddAsteroidEvent());
      }
      final now = DateTime.now();
      final updated = state.asteroids.where((a) {
        if (a.hp < 0) {
          return false;
        }
        if (a.isExploding) {
          final duration = now.difference(a.explosionStartTime!);
          return duration.inMilliseconds < 100;
        }
        return a.position < sl<ScreenSize>().height;
      }).map((asteroid) {
        if (!asteroid.isExploding) {
          return asteroid.copyWith(position: asteroid.position + asteroid.speed / (asteroid.hp / 100));
        }
        return asteroid;
      }).toList();

      emit(state.copyWith(asteriods: updated));
    });
    on<DamagedAsteroidEvent>((event, emit) {
      // Event :
      // List <Asteroid> asteroid;
      // List <Shoot> shoot; // imgUrl , Position(dx , dy)
      final double cellSize = 100;
      final asteroidGrid = <Point<int>, List<Asteroid>>{};

      for (final asteroid in state.asteroids) {
        final x = (asteroid.line - 0.5) * (sl<ScreenSize>().width / AsteroidsResources.maxNoLine) - 25;
        final y = asteroid.position;
        final cell = getGridCell(x, y, cellSize);
        asteroidGrid.putIfAbsent(cell, () => []).add(asteroid);
      }

      final updated = <Asteroid>[];

      for (final shoot in event.shoot) {
        final shootX = shoot.dx + 3;
        final shootY = shoot.dy + 6;
        final shootCell = getGridCell(shootX, shootY, cellSize);
        // مر على الخلية والجيران فقط (3x3 مربعات)
        for (int dx = -1; dx <= 1; dx++) {
          for (int dy = -1; dy <= 1; dy++) {
            final neighbor = Point(shootCell.x + dx, shootCell.y + dy);
            final asteroids = asteroidGrid[neighbor];
            if (asteroids == null) continue;

            for (var i = 0; i < asteroids.length; i++) {
              final asteroid = asteroids[i];

              final ax = (asteroid.line - 0.5) * (sl<ScreenSize>().width / AsteroidsResources.maxNoLine);
              final ay = asteroid.position + 25;

              final distance = sqrt(pow(ax - shootX, 2) + pow(ay - shootY, 2));
              if (distance < 25 && asteroid.explosionStartTime == null) {
                // ضرَب الكويكب
                final updatedAsteroid = asteroid.copyWith(hp: asteroid.hp - 50);
                if (updatedAsteroid.hp > 0) {
                  updated.add(updatedAsteroid);
                } else {
                  updated.add(asteroid.copyWith(
                    hp: 0,
                    speed: 0,
                    isExploding: true,
                    explosionStartTime: DateTime.now(),
                  ));
                }
                // إحذف من الشبكة حتى ما ينضرب مرتين
                asteroids.removeAt(i);
                break;
              }
            }
          }
        }
      }

      // أضف الكويكبات اللي ما انضربت
      for (var list in asteroidGrid.values) {
        for (final a in list) {
          if (!updated.contains(a)) updated.add(a);
        }
      }

      emit(state.copyWith(asteriods: updated));
    });
  }
  Point<int> getGridCell(double x, double y, double cellSize) {
    return Point((x / cellSize).floor(), (y / cellSize).floor());
  }
}
