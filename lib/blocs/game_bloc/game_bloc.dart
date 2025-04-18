import 'dart:async';
import 'dart:ui';

import 'package:asteroid_bomber/constants/layout_constants.dart';
import 'package:asteroid_bomber/models/bullet_model.dart';
import 'package:asteroid_bomber/resources/images_resources.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_event.dart';
part 'game_state.dart';

class RocketBloc extends Bloc<RocketEvent, RocketState> {
  Timer? _autoFireTimer;
  Timer? _bulletUpdateTimer;
  static const double bulletSpeed = 10.0;
  static const Duration firingInterval = Duration(milliseconds: 250);

  RocketBloc() : super(RocketState.initial()) {
    // Rocket events
    on<RocketPositionUpdatedEvent>(_onRocketPositionUpdated);
    on<RocketPositionChangedEvent>(_onRocketPositionChanged);
    on<RocketScreenInitializedEvent>(_onRocketScreenInitialized);

    // Bullet events
    on<BulletFiredEvent>(_onBulletFired);
    on<BulletsUpdatedEvent>(_onBulletsUpdated);
    on<StartAutoFireEvent>(_onStartAutoFire);
    on<StopAutoFireEvent>(_onStopAutoFire);

    // Timer to update bullet positions (every 16ms ~ 60 FPS)
    _bulletUpdateTimer = Timer.periodic(const Duration(milliseconds: 16),
        (timer) => add(BulletsUpdatedEvent()));
  }

  // Rocket event handlers
  void _onRocketPositionUpdated(
    RocketPositionUpdatedEvent event,
    Emitter<RocketState> emit,
  ) {
    final newX = (state.rocketPosition.dx + event.offset.dx)
        .clamp(0.0, state.screenSize.width - LayoutConstants.rocketSize.width);
    final newY = state.rocketPosition.dy;

    final newPosition = Offset(newX, newY);
    emit(state.copyWith(rocketPosition: newPosition));

    // Auto-fire from the new position
    _updateFiringPosition();
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

    // _updateFiringPosition();
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

    // Start auto-firing once the screen is initialized
    _startAutoFiring();
  }

  // Bullet event handlers
  void _onBulletFired(BulletFiredEvent event, Emitter<RocketState> emit) {
    final newBullet = BulletModel(
      imageUrl: ImagesResources.rocketImagePath,
      position: event.startPosition,
    );

    emit(state.copyWith(bullets: [...state.bullets, newBullet]));
  }

  void _onBulletsUpdated(BulletsUpdatedEvent event, Emitter<RocketState> emit) {
    final updatedBullets = state.bullets
        .whereType<BulletModel>()
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

  void _onStartAutoFire(StartAutoFireEvent event, Emitter<RocketState> emit) {
    _startAutoFiring();
  }

  void _onStopAutoFire(StopAutoFireEvent event, Emitter<RocketState> emit) {
    _autoFireTimer?.cancel();
  }

  // Helper methods
  void _startAutoFiring() {
    _autoFireTimer?.cancel(); // avoid duplicates
    _autoFireTimer = Timer.periodic(firingInterval, (timer) {
      final rocketTipX =
          state.rocketPosition.dx + (LayoutConstants.rocketSize.width / 2);
      final rocketTipY = state.rocketPosition.dy;
      add(BulletFiredEvent(Offset(rocketTipX, rocketTipY)));
    });
  }

  void _updateFiringPosition() {
    // If auto-firing is active, restart it to use the new position
    if (_autoFireTimer != null && _autoFireTimer!.isActive) {
      _startAutoFiring();
    }
  }

  @override
  Future<void> close() {
    _autoFireTimer?.cancel();
    _bulletUpdateTimer?.cancel();
    return super.close();
  }
}
