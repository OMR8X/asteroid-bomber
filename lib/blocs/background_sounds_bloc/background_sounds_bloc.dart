import 'package:asteroid_bomber/resources/sounds_recources.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:audioplayers/audioplayers.dart';
part 'background_sounds_event.dart';
part 'background_sounds_state.dart';

class BackgroundSoundsBloc extends Bloc<BackgroundSoundsEvent, BackgroundSoundsState> {
  final player = AudioPlayer();
  BackgroundSoundsBloc() : super(BackgroundSoundsInitial()) {
    on<BackgroundSoundsStartEvent>((event, emit) async {
      await player.setVolume(0.5);
      await player.play(AssetSource(SoundsRecourses.sound1));
    });
    on<BackgroundSoundsStopEvent>((event, emit) async {
      await player.stop();
    });
  }
}
