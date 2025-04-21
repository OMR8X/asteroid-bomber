import 'package:asteroid_bomber/resources/sounds_recources.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:audioplayers/audioplayers.dart';
part 'background_sounds_event.dart';
part 'background_sounds_state.dart';

class BackgroundSoundsBloc extends Bloc<BackgroundSoundsEvent, BackgroundSoundsState> {
  final AudioPlayer backgroundPlayer = AudioPlayer(playerId: "bg_player");
  final AudioPlayer effectPlayer = AudioPlayer(playerId: "effect_player");
  BackgroundSoundsBloc() : super(BackgroundSoundsInitial()) {
    on<BackgroundSoundsStartEvent>((event, emit) async {
      await backgroundPlayer.setPlayerMode(PlayerMode.mediaPlayer);
      await backgroundPlayer.setReleaseMode(ReleaseMode.loop);
      await backgroundPlayer.setVolume(0.5);
      await backgroundPlayer.play(AssetSource(SoundsRecourses.sound1));
    });
    on<BackgroundSoundsStopEvent>((event, emit) async {
      await backgroundPlayer.stop();
    });
    on<BackgroundSoundsExplosionEvent>((event, emit) async {
      await effectPlayer.setPlayerMode(PlayerMode.lowLatency);
      //await explosionPlayer.stop();
      await effectPlayer.setVolume(0.8);
      await effectPlayer.play(AssetSource(SoundsRecourses.beoSound));
    });
  }
}
