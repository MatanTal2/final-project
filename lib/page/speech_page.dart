import 'dart:developer';
import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:final_project/api/pdf_api.dart';
import 'package:final_project/api/pdf_stt_api.dart';
import 'package:final_project/api/speech_api.dart';
import 'package:final_project/model/speech_data.dart';
import 'package:final_project/model/stt_body.dart';
import 'package:final_project/model/stt_subject.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import '../model/personal_info.dart';
import '../presentation/utils.dart';
import '../widget/navigation_drawer_widget.dart';
//import '../widget/navigation_drawer_widget.dartimport 'dart:io';

class SpeechPage extends StatefulWidget {
  const SpeechPage({Key? key}) : super(key: key);

  @override
  State<SpeechPage> createState() => _SpeechPageState();
}

class _SpeechPageState extends State<SpeechPage> {
  final _auth = FirebaseAuth.instance;
  String _textBody = 'Body:\nPress the button and start speaking';
  String _textTitle = "Title:";
  bool _isListening = false;
  String _userFileName = 'newFile';
  String _currentUserEmail = '';
  String _currentUserName = '';

  int _currentIndex = 0;
  final _fileNameController = TextEditingController();

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
                        await FlutterClipboard.copy(_textTitle + '\n' + _textBody);
                        // feedback to user when click the button
                        // TODO: add to Utils showSnackBar more option.
                        Utils.showSnackBar(
                            "Copied to clipboard", Colors.tealAccent);
                      },
                      icon: const Icon(
                        Icons.content_copy,
                      ),
                    )),
            Builder(
                builder: (context) => IconButton(
                      onPressed: () async {
                        // the data that we put in.
                        final date = DateTime.now();
                        final dueDate = date.add(const Duration(days: 7));
                        _currentUserName =
                            _auth.currentUser?.displayName ?? 'empty';
                        _currentUserEmail = _auth.currentUser?.email ?? 'empty';

                        // create file name
                        await openDialog();
                        String fileName = _userFileName + '.pdf';
                        log('file name: $fileName');

                        final speechData = SpeechData(
                          sttSubject: STTSubject(subject: _textTitle),
                          sttBody: STTBody(body: _textBody),
                          personalInfo: PersonalInfo(
                            name: _currentUserName,
                            mail: _currentUserEmail,
                          ),
                        );

                        final pdfFile =
                            await PdfSTTApi.generate(speechData, fileName);

                        PdfApi.openFile(pdfFile);

                      },
                      icon: const Icon(
                        Icons.picture_as_pdf,
                      ),
                    )),
          ],
        ),
        drawer: NavigationDrawerWidget(),
        body: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(30.0).copyWith(bottom: 150.0),
          child: Column(
            children: [
              Text(
                _textTitle,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _textBody,
                style: const TextStyle(
                  fontSize: 26.0,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            currentIndex: _currentIndex,
            selectedItemColor: Colors.amber,
            onTap: (index) => setState(() => _currentIndex = index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.text_fields_outlined,
                  size: 32.0,
                ),
                label: 'body',
                backgroundColor: Colors.teal,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.title,
                  size: 32.0,
                ),
                label: 'title',
                backgroundColor: Colors.teal,
              ),
            ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: _isListening,
          endRadius: 75.0,
          glowColor: Colors.white70,
          child: FloatingActionButton(
            onPressed: () {
              if (_currentIndex == 0) toggleMultiRecording(_textTitle);
              if (_currentIndex == 1) toggleMultiRecording(_textBody);
            },
            child: Icon(
              _isListening ? Icons.mic : Icons.mic_none,
              size: 36.0,
            ),
          ),
        ),
      );

  Future toggleRecording() {
    return SpeechApi.toggleRecording(
        onResult: (text) => setState(() => _textBody = text),
        onListening: (isListening) =>
            setState(() => _isListening = isListening));
  }

  Future toggleMultiRecording(String result) {
    return SpeechApi.toggleRecording(
        onResult: (text) => setState(() => result = text),
        onListening: (isListening) =>
            setState(() => _isListening = isListening));
  }

  Future<void> getName() async {
    try {
      final user = _auth.currentUser!;
      _currentUserName = user.displayName!;
    } on FirebaseAuthException catch (e) {
      log('getNameErr: $e');
    }
  }

  Future<void> getEmail() async {
    try {
      final user = _auth.currentUser!;
      _currentUserEmail = user.email!;
    } on FirebaseAuthException catch (e) {
      log('data: $e');
    }
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('File name'),
            content: TextField(
              autofocus: true,
              maxLength: 40,
              controller: _fileNameController,
              decoration: const InputDecoration(hintText: 'Enter file name'),
            ),
            actions: [
              TextButton(
                onPressed: submit,
                child: const Text('Create'),
              )
            ],
          ));

  void submit() {
    Navigator.of(context).pop();
    _fileNameController.text == ''
        ? _userFileName = DateTime.now().toString()
        : _userFileName = _fileNameController.text;
  }
}
