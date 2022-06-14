import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Contact Us'),
          centerTitle: true,
          backgroundColor: Colors.amber,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              BuildTextField(
                title: 'Subject',
                controller: _subjectController,
              ),
              const SizedBox(
                height: 16.0,
              ),
              BuildTextField(
                  title: 'Message',
                  controller: _messageController,
                  maxLines: 8),
              const SizedBox(
                height: 32.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  minimumSize: const Size.fromHeight(50.0),
                  textStyle: const TextStyle(fontSize: 20.0),
                ),
                onPressed: () {} ,
                // => launchEmail(
                //   toEmail: 'mamash17@gmail.com',
                //   subject: _subjectController.text,
                //   message: _messageController.text,
                // ),
                child: const Text('Send'),
              )
            ],
          ),
        ),
      );

  Widget BuildTextField(
          {required String title,
          required TextEditingController controller,
          int maxLines = 1}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 9.0,
          ),
          TextField(
            controller: controller,
            cursorColor: Colors.white,
            maxLines: maxLines,
            decoration: InputDecoration(
              filled: true,
              focusColor: Colors.white,
              hintText: title,
              fillColor: Colors.white24,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ],
      );

  Future launchEmail(
      {required String toEmail,
      required String subject,
      required String message}) async {
    final url = Uri.dataFromString(
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}');

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}
