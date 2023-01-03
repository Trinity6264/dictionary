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
      log(url);
      await player.setUrl(url);
    } on PlayerException catch (e) {
      emit(const SoundPlayingError(errMessage: 'Error loading audio'));
    }
  }

  // play audio
  void playAudio() async {
    try {
      log('message');
      player.play();
      log(player.playerState.processingState.name);
      if (player.processingState == ProcessingState.loading) {
        emit(const SoundPlaying(playType: PlayType.loading));
      } else if (player.processingState == ProcessingState.idle) {
        emit(const SoundPlaying(playType: PlayType.idle));
      } else if (player.processingState == ProcessingState.ready) {
        emit(const SoundPlaying(playType: PlayType.ready));
      } else if (player.processingState == ProcessingState.buffering) {
        emit(const SoundPlayingError(errMessage: 'Error loading audio'));
      } else {
        emit(const SoundPlaying(playType: PlayType.stop));
      }
    } catch (e) {
      emit(const SoundPlayingError(errMessage: 'Error loading audio'));
    }
  }

  @override
  Future<void> close() {
    player.dispose();
    return super.close();
  }
}
