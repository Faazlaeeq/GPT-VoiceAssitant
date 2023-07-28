import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt_voice_assistant/home/logic/bloc/speech_bloc.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../logic/cubit/mic_cubit.dart';

class SpeechListner {
  late BuildContext context;
  final streamController = StreamController<String>.broadcast();

  late Bloc speechBloc = BlocProvider.of<SpeechBloc>(context);

  SpeechListner(this.context) {
    speechBloc.add(const ConcatenateSpeech(speech: "Hello"));
  }

  SpeechToText speech = SpeechToText();

  void onResultHandler(SpeechRecognitionResult val) {
    speechBloc.add(ConcatenateSpeech(speech: val.recognizedWords));

    stopListening();
  }

  void startListening() async {
    speechBloc.add(EmptySpeech());

    BlocProvider.of<MicCubit>(context).micActive();
    await speech.listen(
      onResult: onResultHandler,
      partialResults: false,
    );
  }

  void stopListening() {
    speech.stop();
    BlocProvider.of<MicCubit>(context).micInactive();
  }

  void speechInit() {
    speech.initialize().then((available) {
      if (available) {
        BlocProvider.of<MicCubit>(context).micActive();
        startListening();
      } else {
        BlocProvider.of<MicCubit>(context).micError();
      }
    });
  }

  // Closing the stream when the listen function completes or isSpeechAvailable is false
  Future<void> close() async {
    streamController.stream.listen((_) {}).cancel();
    streamController.close();
  }
}
