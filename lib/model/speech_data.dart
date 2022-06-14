import 'package:final_project/model/personal_info.dart';
import 'package:final_project/model/stt_body.dart';
import 'package:final_project/model/stt_subject.dart';


class SpeechData {
  final PersonalInfo personalInfo;
  final STTSubject sttSubject;
  final STTBody sttBody;

  const SpeechData({
    required this.personalInfo,
    required this.sttSubject,
    required this.sttBody,
  });
}
