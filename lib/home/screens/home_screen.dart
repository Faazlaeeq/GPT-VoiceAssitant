import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gpt_voice_assistant/home/screens/speech_listener.dart';

import '../logic/bloc/speech_bloc.dart';
import '../widgets/customwidgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SpeechListner speechListener;
  List<Widget> customWidgets = [];
  @override
  void initState() {
    super.initState();
    speechListener = SpeechListner(context);
    speechListener.speechInit();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Voice Assistant"),
      ),
      body: Column(children: [
        Expanded(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ListTile(
                  title: Text("Hello"),
                  subtitle: Text("How can I help you?"),
                ),

                Flexible(
                    fit: FlexFit.loose,
                    child: BlocConsumer<SpeechBloc, SpeechState>(
                      builder: (context, state) => ListView.builder(
                        itemCount: customWidgets.length,
                        itemBuilder: (context, index) {
                          if (state is SpeechLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return customWidgets[index];
                        },
                      ),
                      listener: (ctx, state) {
                        if (state is SpeechUpdated) {
                          customWidgets.add(
                              CustomWidgets().textBlock(state.speech, context));
                        } else if (state is SpeechResponse) {
                          customWidgets.add(CustomWidgets()
                              .textBlock(state.res, context, isRes: true));
                        }
                      },
                    )),
                // CustomWidgets().textBlock(context),
              ],
            ),
          ),
        ),
        Row(
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ask me anything',
                  ),
                ),
              ),
            ),
            CustomWidgets().floatingButton(context),
          ],
        )
      ]),
    );
  }
}
