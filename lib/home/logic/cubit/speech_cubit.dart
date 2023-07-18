import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'speech_state.dart';

class SpeechCubit extends Cubit<SpeechState> {
  SpeechCubit() : super(SpeechInitial());

  String speech = "";

  void addWord(String word) {
    speech += word;
  }
}
