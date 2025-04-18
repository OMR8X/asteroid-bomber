import 'dart:async';
import 'dart:ui';

import 'package:asteroid_bomber/blocs/asteriods_bloc/asteriods_bloc.dart';
import 'package:asteroid_bomber/constants/layout_constants.dart';
import 'package:asteroid_bomber/models/bullet_model.dart';
import 'package:asteroid_bomber/models/screen_size.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection/app_inj.dart';

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
      0.0,
      sl<ScreenSize>().width - LayoutConstants.rocketSize.width,
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
    sl<AsteroidsBloc>().add(
      DamagedAsteroidEvent(
        ship: state.rocketPosition,
        shoot: updatedBullets.map((e) => e.position).toList(),
      ),
    );
    emit(state.copyWith(bullets: updatedBullets));
  }
}
