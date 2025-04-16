import 'package:asteroid_bomber/constants/layout_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'rocket_event.dart';
part 'rocket_state.dart';

class RocketBloc extends Bloc<RocketEvent, RocketState> {
  RocketBloc() : super(RocketState.initial()) {
    on<RocketPositionUpdatedEvent>(_onPositionUpdated);
    on<RocketScreenInitializedEvent>(_onScreenInitialized);
  }

  void _onPositionUpdated(
    RocketPositionUpdatedEvent event,
    Emitter<RocketState> emit,
  ) {
    final newX = (state.position.dx + event.offset.dx)
        .clamp(0.0, state.screenSize.width - LayoutConstants.rocketSize.width);

    final newY = state.position.dy;

    emit(state.copyWith(position: Offset(newX, newY)));
  }

  void _onScreenInitialized(
      RocketScreenInitializedEvent event, Emitter<RocketState> emit) {
    final centerX =
        (event.screenSize.width - LayoutConstants.rocketSize.width) / 2;
    final lowerY =
        event.screenSize.height * LayoutConstants.rocketInitialYOffsetFraction;

    emit(state.copyWith(
      position: Offset(centerX, lowerY),
      screenSize: event.screenSize,
      lowerBoundY: lowerY,
    ));
  }
}
