import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gpt_state.dart';

class GptCubit extends Cubit<GptState> {
  GptCubit() : super(GptInitial());
}
