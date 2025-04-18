part of 'background_bloc.dart';

sealed class BackgroundState extends Equatable {
  const BackgroundState();

  @override
  List<Object> get props => [];
}

final class BackgroundInitial extends BackgroundState {
  const BackgroundInitial();
}

final class BackgroundScrollInProgress extends BackgroundState {
  final double scrollValue;

  const BackgroundScrollInProgress(this.scrollValue);

  @override
  List<Object> get props => [scrollValue];
}
