import 'package:avatar_glow/avatar_glow.dart';
import 'package:final_project/api/speech_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';

import '../presentation/utils.dart';
import '../widget/navigation_drawer_widget.dart';

class SpeechPage extends StatefulWidget {
  const SpeechPage({Key? key}) : super(key: key);

  @override
  State<SpeechPage> createState() => _SpeechPageState();
}

class _SpeechPageState extends State<SpeechPage> {
  String _text = 'Press the button and start speaking';
  bool _isListening = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Speech To Text",
          ),
          centerTitle: true,
          actions: [
            Builder(
                builder: (context) => IconButton(
                      onPressed: () async {
                        await FlutterClipboard.copy(_text);
                        // feedback to user when click the button
                        // TODO: add to Utils showSnackBar more option.
                        Utils.showSnackBar("Copied to clipboard", Colors.tealAccent);
                      },
                      icon: const Icon(Icons.content_copy),
                    )),
          ],
        ),
        drawer: NavigationDrawerWidget(),
        body: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(30.0).copyWith(bottom: 150.0),
          child: Text(
            _text,
            style: const TextStyle(
              fontSize: 32.0,
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: _isListening,
          endRadius: 75.0,
          glowColor: Theme.of(context).primaryColor,
          child: FloatingActionButton(
            onPressed: toggleRecording,
            child: Icon(
              _isListening ? Icons.mic : Icons.mic_none,
              size: 36.0,
            ),
          ),
        ),
      );

  Future toggleRecording() => SpeechApi.toggleRecording(
      onResult: (text) => setState(() => _text = text),
      onListening: (isListening) => setState(() => _isListening = isListening));
}
