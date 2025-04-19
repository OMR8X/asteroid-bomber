part of 'score_bloc.dart';

abstract class ScoreEvent extends Equatable {
  const ScoreEvent();

  @override
  List<Object> get props => [];
}

class IncrementScoreEvent extends ScoreEvent {
  final int points;

  const IncrementScoreEvent({this.points = 10});

  @override
  List<Object> get props => [points];
}

class ResetScoreEvent extends ScoreEvent {}