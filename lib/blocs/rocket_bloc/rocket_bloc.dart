import 'dart:ui';

import 'package:asteroid_bomber/blocs/asteriods_bloc/asteriods_bloc.dart';
import 'package:asteroid_bomber/constants/layout_constants.dart';
import 'package:asteroid_bomber/models/bullet_model.dart';
import 'package:asteroid_bomber/models/screen_size.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection/app_inj.dart';
import '../../resources/asteroids_resources.dart';
import '../background_sounds_bloc/background_sounds_bloc.dart';

part 'rocket_event.dart';
part 'rocket_state.dart';

class RocketBloc extends Bloc<RocketEvent, RocketState> {
  static const double bulletSpeed = 12.0;
  static const Duration firingInterval = Duration(milliseconds: 250);
  RocketBloc() : super(RocketState.initial()) {
    on<RocketPositionChangedEvent>(_onRocketPositionChanged);
    on<RocketScreenInitializedEvent>(_onRocketScreenInitialized);
    on<BulletFiredEvent>(_onBulletFired);
    on<BulletsUpdatedEvent>(_onBulletsUpdated);
  }

  void _onRocketPositionChanged(
    RocketPositionChangedEvent event,
    Emitter<RocketState> emit,
  ) {
    final clampedX = event.position.dx.clamp(
      -50.0,
      sl<ScreenSize>().width - LayoutConstants.rocketSize.width + 50,
    );
    final newPosition = Offset(clampedX, state.rocketPosition.dy);
    emit(state.copyWith(rocketPosition: newPosition));
  }

  void _onRocketScreenInitialized(
    RocketScreenInitializedEvent event,
    Emitter<RocketState> emit,
  ) {
    final centerX = (sl<ScreenSize>().width - LayoutConstants.rocketSize.width) / 2;
    final lowerY = sl<ScreenSize>().height * LayoutConstants.rocketInitialYOffsetFraction;

    emit(state.copyWith(
      rocketPosition: Offset(centerX, lowerY),
      lowerBoundY: lowerY,
    ));

    // _startAutoFiring();
  }

  void _onBulletFired(BulletFiredEvent event, Emitter<RocketState> emit) {
    final newBullet = BulletModel(
      position: event.startPosition,
      isExploding: false,
    );

    emit(state.copyWith(bullets: [...state.bullets, newBullet]));
  }

  void _onBulletsUpdated(BulletsUpdatedEvent event, Emitter<RocketState> emit) {
    final updatedBullets = state.bullets
        .map((bullet) => bullet.copyWith(
              position: Offset(
                bullet.position.dx,
                bullet.position.dy - bulletSpeed,
              ),
            ))
        .where((bullet) => bullet.position.dy > -50)
        .toList();
    final bulletPositions = updatedBullets.map((b) => b.position).toList();
    sl<AsteroidsBloc>().add(
      DamagedAsteroidEvent(
        ship: state.rocketPosition,
        shoot: bulletPositions,
      ),
    );

    final newUpdatedBullets = updatedBullets.map((bullet) {
      bool hit = false;

      for (final asteroid in sl<AsteroidsBloc>().state.asteroids) {
        final ax = (asteroid.line - 0.5) * (sl<ScreenSize>().width / AsteroidsResources.maxNoLine);
        final ay = asteroid.position + 25;
        final distance = (bullet.position - Offset(ax, ay)).distance;

        if (distance < 15 && asteroid.explosionStartTime == null) {
          sl<BackgroundSoundsBloc>().add(const BackgroundSoundsExplosionEvent());
          hit = true;
          break;
        }
      }

      if (hit) {
        return bullet.copyWith(
          isExploding: true,
          explosionStartTime: DateTime.now(),
        );
      } else {
        return bullet;
      }
    }).where((bullet) {
      // نظهر الطلقة إذا ما انفجرت أو لسه تأثير الانفجار ما خلص
      if (bullet.isExploding && bullet.explosionStartTime != null) {
        return DateTime.now().difference(bullet.explosionStartTime!).inMilliseconds < 200;
      }
      return bullet.position.dy > -50;
    }).toList();

    emit(state.copyWith(bullets: newUpdatedBullets));
  }
}
