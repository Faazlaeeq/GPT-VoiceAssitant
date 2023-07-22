import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/cubit/mic_cubit.dart';
import '../screens/speech_listener.dart';

class CustomWidgets {
  final streamController = StreamController<String>.broadcast();

  void listen(BuildContext ctx) {
    final sl = SpeechListner(ctx);
    sl.speechInit();

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

  Widget textBlock(String text, BuildContext context, {bool isRes = false}) {
    return Row(
      mainAxisAlignment:
          isRes ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: isRes ? Colors.grey[900] : Colors.blueAccent,
              border: Border.all(
                  color: isRes ? Colors.grey.shade900 : Colors.blueAccent),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            )),
      ],
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
