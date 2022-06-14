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
  String _text = 'Press the button and start speaking';
  bool _isListening = false;
  final String _userFileName = 'newFile';
  final file = File('example.pdf');
  String _currentUserEmail = '';
  String _currentUserName = '';

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

                        final speechData = SpeechData(
                          sttSubject: STTSubject(subject: _text),
                          sttBody: STTBody(body: _text),
                          personalInfo: PersonalInfo(
                            name: _currentUserName,
                            mail: _currentUserEmail,
                          ),
                        );
                        String fileName = _userFileName + '.pdf';
                        log('file name: $fileName');
                        final pdfFile =
                            await PdfSTTApi.generate(speechData, fileName);

                        PdfApi.openFile(pdfFile);

                        await _createPdf();
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
          glowColor: Theme.of(context).secondaryHeaderColor,
          child: FloatingActionButton(
            onPressed: toggleRecording,
            child: Icon(
              _isListening ? Icons.mic : Icons.mic_none,
              size: 36.0,
            ),
          ),
        ),
      );

  Future toggleRecording() {
    return SpeechApi.toggleRecording(
      onResult: (text) => setState(() => _text = text),
      onListening: (isListening) => setState(() => _isListening = isListening));
  }

  Future<void> _createPdf() async {
    final pdf = pw.Document();
    log('pdf: $pdf');
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Hello World!'),
        ),
      ),
    );

    await file.writeAsBytes(await pdf.save());
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

      var temp = 'abc@gmail.com';
      _currentUserEmail = user.email!;
    } on FirebaseAuthException catch (e) {
      log('data: $e');
    }
  }
}
