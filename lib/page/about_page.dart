import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('About'),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade800,
                  radius: 100.0,
                  child: ClipOval(child: Image.asset(
                    'assets/logo.png',),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  '''Welcome to the "Docu Audio" app!''',
                  style: TextStyle(
                      fontSize: 23.0,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  '''A system capable of deciphering human speech into text.\n\nBy clicking on the microphone you can start recording to the document and can save the transcript as a PDF or just copy it.
                ''',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  '''The application presents a readable transcript in Hebrew, without spelling errors, fast and easy to use.''',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  '''Hope you enjoy using the app. For further questions contact us via the "contect us" button.''',
                  style: TextStyle(fontSize: 16.0),
                )
              ],
            ),
          ),
        ),
      );
}
