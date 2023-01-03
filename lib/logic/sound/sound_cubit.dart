import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dictionary/constant/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

part 'sound_state.dart';

class SoundCubit extends Cubit<SoundState> {
  final AudioPlayer player;
  SoundCubit({required this.player})
      : super(const SoundPlaying(playType: PlayType.loading));

// load sound

  void loadSound({required String url}) async {
    try {
      await player.setUrl(url);
      player.play();
      playAudio();
    } on PlayerException catch (e) {
      log(e.message ?? '');
    }
  }

  void checkingSomething() {
    log(player.processingState.name);
    log(player.playerState.toString());
  }

  // play audio
  void playAudio() async {
    if (player.processingState == ProcessingState.loading) {
      emit(const SoundPlaying(playType: PlayType.loading));
    } else if (player.processingState == ProcessingState.idle) {
      emit(const SoundPlaying(playType: PlayType.idle));
    } else if (player.processingState == ProcessingState.ready) {
      emit(const SoundPlaying(playType: PlayType.ready));
    } else if (player.processingState == ProcessingState.buffering) {
      emit(const SoundPlaying(playType: PlayType.buffering));
    } else {
      emit(const SoundPlaying(playType: PlayType.stop));
    }
  }

  @override
  Future<void> close() {
    player.dispose();
    return super.close();
  }
}
