import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'speech_event.dart';
part 'speech_state.dart';

class SpeechBloc extends Bloc<SpeechEvent, SpeechState> {
  String speech = "";

  SpeechBloc() : super(SpeechInitial()) {
    on<SpeechEvent>((event, emit) {
      if (event is ConcatenateSpeech) {
        speech += " ${event.speech}";
        emit(SpeechUpdated(speech));
      }
      if (event is EmptySpeech) {
        speech = "";
        emit(SpeechEmpty());
      }
    });
  }
}
