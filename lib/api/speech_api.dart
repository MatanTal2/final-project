import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechApi {
  static final _speech = SpeechToText();

  static Future<bool> toggleRecording({
    required Function(String text) onResult,
    required ValueChanged<bool> onListening,
  }) async {
    if (_speech.isListening) {
      _speech.stop();
      return true;
    }
    final isAvailable = await _speech.initialize(
      finalTimeout: Duration(minutes: 1),
      //TODO test for timeout, maybe give the user choose.
      onStatus: (status) => onListening(_speech.isListening),
      onError: (e) => print('Error $e'),
    );

    var locales = await speechLanguagePick();
    // TODO
    // Some UI or other code to select a locale from the list
    // resulting in an index, selectedLocale

    if (isAvailable) {
      _speech.listen(
          localeId: 'iw_IL',
          onResult: (value) => onResult(value.recognizedWords));
    }
    return isAvailable;
  }

  static Future<List<LocaleName>> speechLanguagePick() async {
    return await _speech.locales();
  }
}
