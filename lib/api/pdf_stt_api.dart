import 'dart:io';
import 'package:final_project/api/pdf_api.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../model/personal_info.dart';
import '../model/speech_data.dart';

class PdfSTTApi {
  static Future<File> generate(SpeechData textVoice, String fileName) async {
    final pdf = Document();

    var myTheme = ThemeData.withFont(
      base: Font.ttf(
          await rootBundle.load("assets/fonts/openSans/OpenSans-Regular.ttf")),
      bold: Font.ttf(
          await rootBundle.load("assets/fonts/openSans/OpenSans-Bold.ttf")),
      italic: Font.ttf(
          await rootBundle.load("assets/fonts/openSans/OpenSans-Italic.ttf")),
      boldItalic: Font.ttf(await rootBundle
          .load("assets/fonts/openSans/OpenSans-BoldItalic.ttf")),
    );

    pdf.addPage(MultiPage(
      theme: myTheme,
      textDirection: TextDirection.rtl,
      build: (context) {
        return [
          buildHeader(textVoice),
          SizedBox(height: 3 * PdfPageFormat.cm),
          buildSubject(textVoice),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildBody(textVoice),
          Divider(),
        ];
      },
      footer: (context) => buildFooter(textVoice),
    ));
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

  static Widget buildPersonDetails(PersonalInfo person) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            person.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(person.mail),
        ],
      );

  static Widget buildTitle(SpeechData title) => Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title.sttBody.body,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      ));

  static Widget buildSubject(SpeechData subject) => Container(
    alignment: Alignment.topRight,
    child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          //mainAxisSize: MainAxisSize.min,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(subject.sttSubject.subject,
                textDirection: TextDirection.rtl,

                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      );

  static Widget buildBody(SpeechData body) => Container(
        alignment: Alignment.topRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              body.sttBody.body,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 0.8 * PdfPageFormat.cm),
            //Text(invoice.sttBody.text),
            //SizedBox(height: 0.8 * PdfPageFormat.cm),
          ],
        ),
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
      crossAxisAlignment: CrossAxisAlignment.end,
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
