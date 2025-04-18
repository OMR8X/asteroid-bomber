import 'dart:math';

import 'package:asteroid_bomber/resources/asteroids_resources.dart';
import 'package:asteroid_bomber/resources/images_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      int imgPathNum = random.nextInt(8) + 1;
      int asteroidSize = imgPathNum % 2 + 1;
      final newAsteroid = Asteroid(
        id: _idCounter++,
        hp: 100 * asteroidSize,
        line: newLine,
        speed: 30 + random.nextDouble() * 6,
        imagePath: "${ImagesResources.asteroidImagePath}$imgPathNum.png",
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
      // Event :
      // List <Asteroid> asteroid;
      // List <Shoot> shoot; // imgUrl , Position(dx , dy)
      final double cellSize = 100;
      final asteroidGrid = <Point<int>, List<Asteroid>>{};

      for (final asteroid in event.asteroid) {
        final x = asteroid.line * (event.screenWidth / AsteroidsResources.maxNoLine) + 25;
        final y = asteroid.position;
        final cell = getGridCell(x, y, cellSize);
        asteroidGrid.putIfAbsent(cell, () => []).add(asteroid);
      }

      final updated = <Asteroid>[];

      for (final shoot in event.shoot) {
        final shootX = shoot.dx;
        final shootY = shoot.dy;
        final shootCell = getGridCell(shootX, shootY, cellSize);

        // مر على الخلية والجيران فقط (3x3 مربعات)
        for (int dx = -1; dx <= 1; dx++) {
          for (int dy = -1; dy <= 1; dy++) {
            final neighbor = Point(shootCell.x + dx, shootCell.y + dy);
            final asteroids = asteroidGrid[neighbor];
            if (asteroids == null) continue;

            for (var i = 0; i < asteroids.length; i++) {
              final asteroid = asteroids[i];

              final ax = asteroid.line * (event.screenWidth / AsteroidsResources.maxNoLine) + 25;
              final ay = asteroid.position;

              final distance = sqrt(pow(ax - shootX, 2) + pow(ay - shootY, 2));
              if (distance < 30) {
                // ضرَب الكويكب
                final updatedAsteroid = asteroid.copyWith(hp: asteroid.hp - 50);
                if (updatedAsteroid.hp > 0) updated.add(updatedAsteroid);

                // إحذف من الشبكة حتى ما ينضرب مرتين
                asteroids.removeAt(i);
                break;
              }
            }
          }
        }
      }

      // أضف الكويكبات اللي ما انضربت
      asteroidGrid.values.forEach((list) {
        for (final a in list) {
          if (!updated.contains(a)) updated.add(a);
        }
      });

      emit(state.copyWith(asteriods: updated));
    });
  }
  Point<int> getGridCell(double x, double y, double cellSize) {
    return Point((x / cellSize).floor(), (y / cellSize).floor());
  }
}

/*
/// [First Algotithm] 
/// O(Asteroid * Shoot)
final updatedAsteroids = event.asteroid
          .map((asteroid) {
            bool gotHit = false;
            for (final shoot in event.shoot) {
              //
              final asteroidX = asteroid.line * (event.screenWidth / AsteroidsResources.maxNoLine);
              final asteroidY = asteroid.position;
              //
              final shootX = shoot.dx;
              final shootY = shoot.dy;
              //
              const asteroidRadius = 25.0;
              const shootRadius = 5.0;
              //
              final dx = asteroidX - shootX;
              final dy = asteroidY - shootY;
              final distance = sqrt(dx * dx + dy * dy);
              //
              if (distance < (asteroidRadius + shootRadius)) {
                gotHit = true;
                break;
              }
            }
            if (gotHit) {
              return asteroid.copyWith(hp: asteroid.hp - 50);
            }
            return asteroid;
          })
          .where((a) => a.hp > 0)
          .toList();
      emit(state.copyWith(asteriods: updatedAsteroids));
*/
