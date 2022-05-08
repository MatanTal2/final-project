import 'package:flutter/material.dart';

class Authentication extends StatelessWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: (){},
              child: const Text(
                "login"
              ),),
          ElevatedButton(
              onPressed: () {},
              child: const Text("register"),
          )
        ],
      ),
    );
  }
}
