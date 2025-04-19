import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'score_event.dart';
part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  ScoreBloc() : super(ScoreState.initial()) {
    on<IncrementScoreEvent>(_onIncrementScore);
    on<ResetScoreEvent>(_onResetScore);
  }

  void _onIncrementScore(IncrementScoreEvent event, Emitter<ScoreState> emit) {
    emit(state.copyWith(currentScore: state.currentScore + event.points));
  }

  void _onResetScore(ResetScoreEvent event, Emitter<ScoreState> emit) {
    emit(state.copyWith(currentScore: 0));
  }
}