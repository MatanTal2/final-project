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
        body: const Center(
          child: Text(
            'This is about',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
}
