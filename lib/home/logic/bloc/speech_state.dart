part of 'speech_bloc.dart';

@immutable
abstract class SpeechState extends Equatable {
  const SpeechState();

  @override
  List<Object> get props => [];
}

class SpeechInitial extends SpeechState {}

class SpeechUpdated extends SpeechState {
  final String speech;

  const SpeechUpdated(this.speech);

  @override
  List<Object> get props => [speech];
}

class SpeechEmpty extends SpeechState {}
