import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt_voice_assistant/home/logic/bloc/speech_bloc.dart';
import 'package:gpt_voice_assistant/home/logic/cubit/mic_cubit.dart';
import 'package:gpt_voice_assistant/home/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MicCubit()),
        BlocProvider(create: (_) => SpeechBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Voice Assistant',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
