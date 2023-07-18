import 'package:flutter/material.dart';

import 'package:gpt_voice_assistant/home/screens/speech_listener.dart';

import '../widgets/customwidgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SpeechListner speechListener;

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
        Card(
          child: Column(
            children: [
              const ListTile(
                title: Text("Hello"),
                subtitle: Text("How can I help you?"),
              ),
              CustomWidgets().textBlock(context),
            ],
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
