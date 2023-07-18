import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt_voice_assistant/home/logic/bloc/speech_bloc.dart';

import '../logic/cubit/mic_cubit.dart';
import '../screens/speech_listener.dart';

class CustomWidgets {
  final streamController = StreamController<String>.broadcast();

  void listen(BuildContext ctx) {
    // final reply = await ApiCall().sendRequest("who are you?");
    StreamSubscription? subscription;
    final sl = SpeechListner(ctx);
    sl.speechInit();

    String result = "";

    subscription = sl.streamController.stream.listen((event) {
      print(event + "by custom widgets");
      result += event;
      ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text(event.toString())));

      subscription!.cancel();
    });

    // print(reply);
  }

  Widget textBlockOld(BuildContext ctx) {
    return StreamBuilder<String>(
      stream: SpeechListner(ctx).streamController.stream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return Text(snapshot
                .data!); // Display the recognized words in the Text widget
          } else {
            return const Text("Listening..."); // Show a message while listening
          }
        } else {
          return const Text(
              "Initializing..."); // Show a message while initializing
        }
      },
    );
  }

  Widget textBlock(BuildContext context) {
    return BlocBuilder<SpeechBloc, SpeechState>(
      builder: (ctx, state) {
        print("State is $state");
        if (state is SpeechUpdated) {
          return Text(state.speech);
        } else {
          return const Text("No speech detected");
        }
      },
    );
  }

  Widget floatingButton(BuildContext context) {
    return BlocBuilder<MicCubit, MicState>(
      builder: (context, state) {
        if (state is MicActive) {
          return FloatingActionButton(
            onPressed: () => listen(context),
            child: const CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }

        if (state is MicInactive) {
          return FloatingActionButton(
            onPressed: () => listen(context),
            child: const Icon(Icons.mic),
          );
        }
        if (state is MicError) {
          return FloatingActionButton(
            onPressed: () => listen(context),
            child: const Icon(Icons.error),
          );
        }
        return FloatingActionButton(
          onPressed: () async => listen(context),
          child: const Icon(Icons.mic),
        );
      },
    );
  }
}
