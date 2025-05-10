import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'background_event.dart';
part 'background_state.dart';

class BackgroundBloc extends Bloc<BackgroundEvent, BackgroundState> {
  Timer? _timer; // The ticker that drives the scroll updates
  double _scrollValue = 0.0;

  BackgroundBloc() : super(const BackgroundInitial()) {
    on<StartBackgroundScroll>(_onStartScroll);
    on<UpdateScrollPosition>(_onUpdateScroll);
  }

  void _onStartScroll(
    StartBackgroundScroll event,
    Emitter<BackgroundState> emit,
  ) {
    // Cancel any existing timer
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(milliseconds: 33), // ~60 FPS
      (timer) {
        _scrollValue += 0.001; // Scroll speed
        if (_scrollValue > 1.0) {
          _scrollValue = 0.0; // Loop back
        }
        // Emit event to update scroll
        add(UpdateScrollPosition(_scrollValue));
      },
    );
  }

  void _onUpdateScroll(
    UpdateScrollPosition event,
    Emitter<BackgroundState> emit,
  ) {
    emit(BackgroundScrollInProgress(event.scrollValue));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
