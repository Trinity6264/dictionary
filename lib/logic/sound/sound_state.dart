part of 'sound_cubit.dart';

abstract class SoundState extends Equatable {
  const SoundState();

  @override
  List<Object> get props => [];
}

class SoundInitial extends SoundState {}

class SoundPlaying extends SoundState {
  final PlayType playType;
  const SoundPlaying({required this.playType});
}
