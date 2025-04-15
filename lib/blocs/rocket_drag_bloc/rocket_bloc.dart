import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'rocket_event.dart';
part 'rocket_state.dart';

class RocketBloc extends Bloc<RocketEvent, RocketState> {
  // Initialize the BLoC with the initial state
  RocketBloc() : super(RocketState.initial()) {
    on<RocketPositionUpdated>(_onPositionUpdated);
  }

  void _onPositionUpdated(
    RocketPositionUpdated event,
    Emitter<RocketState> emit,
  ) {
    final newPosition = Offset(
      state.position.dx + event.offset.dx,
      state.position.dy + event.offset.dy,
    );
    emit(state.copyWith(position: newPosition));
  }
}
