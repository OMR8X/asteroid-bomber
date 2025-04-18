part of 'background_bloc.dart';

sealed class BackgroundEvent extends Equatable {
  const BackgroundEvent();

  @override
  List<Object> get props => [];
}

final class StartBackgroundScroll extends BackgroundEvent {
  const StartBackgroundScroll();
}

final class UpdateScrollPosition extends BackgroundEvent {
  final double scrollValue;

  const UpdateScrollPosition(this.scrollValue);
  @override
  List<Object> get props => [scrollValue];
}
