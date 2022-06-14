import 'dart:io';
import 'package:final_project/api/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import '../model/personal_info.dart';
import '../model/speech_data.dart';

import '../presentation/utils.dart';

class PdfSTTApi {
  static Future<File> generate(SpeechData textVoice, String fileName) async {
    final pdf = Document();
    // TODO alertDialog for the file name.
    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(textVoice),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(textVoice),
        buildSubject(textVoice),
        SizedBox(height: 1 * PdfPageFormat.cm),
        buildBody(textVoice),
        Divider(),
      ],
      footer: (context) => buildFooter(textVoice),
    ));
    //TODO: pass a variable for the file name
    //fileName
    return PdfApi.saveDocument(name: fileName, pdf: pdf);
  }

  static Widget buildHeader(SpeechData textVoice) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 1 * PdfPageFormat.cm),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildPersonDetails(textVoice.personalInfo),
          Container(
            height: 50,
            width: 50,
            child: BarcodeWidget(
              barcode: Barcode.qrCode(),
              data: textVoice.personalInfo.mail,
            ),
          ),
        ],
      ),
      SizedBox(height: 1 * PdfPageFormat.cm),

    ],
  );

  static Widget buildCustomerAddress(PersonalInfo person) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(person.name, style: TextStyle(fontWeight: FontWeight.bold)),
      Text(person.mail),
    ],
  );



  static Widget buildPersonDetails(PersonalInfo person) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(person.name, style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 1 * PdfPageFormat.mm),
      Text(person.mail),
    ],
  );

  static Widget buildTitle(SpeechData invoice) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        invoice.sttBody.body,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 0.8 * PdfPageFormat.cm),
      //Text(invoice.sttBody.text),
      //SizedBox(height: 0.8 * PdfPageFormat.cm),
    ],
  );
  static Widget buildSubject (SpeechData subject) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSimpleText(title: 'Subject:', value: subject.sttSubject.subject),
    ],
  );
  static Widget buildBody (SpeechData body) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        body.sttBody.body,
        style: const TextStyle(fontSize: 16,),
      ),
      SizedBox(height: 0.8 * PdfPageFormat.cm),
      //Text(invoice.sttBody.text),
      //SizedBox(height: 0.8 * PdfPageFormat.cm),
    ],
  );




  static Widget buildFooter(SpeechData invoice) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Divider(),
      SizedBox(height: 2 * PdfPageFormat.mm),
      buildSimpleText(title: '© :', value: 'Ofir ben Zaken & Matan Tal'),
      SizedBox(height: 1 * PdfPageFormat.mm),
    ],
  );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value, style: TextStyle(fontSize: 16)),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}