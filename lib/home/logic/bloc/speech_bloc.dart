import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gpt_voice_assistant/home/repository/api_call.dart';
import 'package:meta/meta.dart';

part 'speech_event.dart';
part 'speech_state.dart';

class SpeechBloc extends Bloc<SpeechEvent, SpeechState> {
  String speech = "";

  SpeechBloc() : super(SpeechInitial()) {
    on<SpeechEvent>((event, emit) async {
      if (event is ConcatenateSpeech) {
        speech += " ${event.speech}";
        emit(SpeechUpdated(speech));
        ApiCall apiCall = ApiCall();
        emit(SpeechLoading());
        String res = await apiCall.sendRequest(event.speech);
        emit(SpeechResponse(res));
      }
      if (event is EmptySpeech) {
        speech = "";
        emit(SpeechEmpty());
      }
    });
  }
}
