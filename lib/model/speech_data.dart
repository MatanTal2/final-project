import 'package:final_project/model/personal_info.dart';
import 'package:final_project/model/stt_body.dart';
import 'package:final_project/model/stt_subject.dart';


class SpeechData {
  final STTSubject sttSubject;
  final STTBody sttBody;
  final PersonalInfo personalInfo;

  const SpeechData({
    required this.sttSubject,
    required this.sttBody,
    required this.personalInfo,
  });
}
