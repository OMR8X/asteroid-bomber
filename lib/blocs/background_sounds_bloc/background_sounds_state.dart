part of 'background_sounds_bloc.dart';

sealed class BackgroundSoundsState extends Equatable {
  const BackgroundSoundsState();
  
  @override
  List<Object> get props => [];
}

final class BackgroundSoundsInitial extends BackgroundSoundsState {}
