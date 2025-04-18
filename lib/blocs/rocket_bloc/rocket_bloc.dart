import 'dart:async';
import 'dart:ui';

import 'package:asteroid_bomber/constants/layout_constants.dart';
import 'package:asteroid_bomber/models/bullet_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'rocket_event.dart';
part 'rocket_state.dart';

class RocketBloc extends Bloc<RocketEvent, RocketState> {
  Timer? _autoFireTimer;
  Timer? _bulletUpdateTimer;
  static const double bulletSpeed = 10.0;
  static const Duration firingInterval = Duration(milliseconds: 250);

  RocketBloc() : super(RocketState.initial()) {
    on<RocketPositionChangedEvent>(_onRocketPositionChanged);
    on<RocketScreenInitializedEvent>(_onRocketScreenInitialized);
    on<BulletFiredEvent>(_onBulletFired);
    on<BulletsUpdatedEvent>(_onBulletsUpdated);

    _bulletUpdateTimer = Timer.periodic(
      const Duration(milliseconds: 16),
      (timer) => add(BulletsUpdatedEvent()),
    );
  }

  void _onRocketPositionChanged(
    RocketPositionChangedEvent event,
    Emitter<RocketState> emit,
  ) {
    final clampedX = event.position.dx.clamp(
      0.0,
      state.screenSize.width - LayoutConstants.rocketSize.width,
    );
    final newPosition = Offset(clampedX, state.rocketPosition.dy);
    emit(state.copyWith(rocketPosition: newPosition));
  }

  void _onRocketScreenInitialized(
    RocketScreenInitializedEvent event,
    Emitter<RocketState> emit,
  ) {
    final centerX =
        (event.screenSize.width - LayoutConstants.rocketSize.width) / 2;
    final lowerY =
        event.screenSize.height * LayoutConstants.rocketInitialYOffsetFraction;

    emit(state.copyWith(
      rocketPosition: Offset(centerX, lowerY),
      screenSize: event.screenSize,
      lowerBoundY: lowerY,
    ));

    _startAutoFiring();
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

    emit(state.copyWith(bullets: updatedBullets));
  }

  void _startAutoFiring() {
    _autoFireTimer?.cancel();
    _autoFireTimer = Timer.periodic(firingInterval, (timer) {
      final rocketTipX =
          state.rocketPosition.dx + (LayoutConstants.rocketSize.width / 2);
      final rocketTipY = state.rocketPosition.dy;
      add(BulletFiredEvent(Offset(rocketTipX, rocketTipY)));
    });
  }

  @override
  Future<void> close() {
    _autoFireTimer?.cancel();
    _bulletUpdateTimer?.cancel();
    return super.close();
  }
}
