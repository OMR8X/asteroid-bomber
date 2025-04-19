part of 'score_bloc.dart';

class ScoreState extends Equatable {
  final int currentScore;
  final int highScore;

  const ScoreState({
    required this.currentScore,
     required this.highScore,
  });

  factory ScoreState.initial() {
    return const ScoreState(
      currentScore: 0,
       highScore: 0, 
    );
  }

  ScoreState copyWith({
    int? currentScore,
     int? highScore,
  }) {
    return ScoreState(
      currentScore: currentScore ?? this.currentScore,
       highScore: highScore ?? this.highScore,
    );
  }

  @override
  List<Object> get props => [currentScore]; 
}