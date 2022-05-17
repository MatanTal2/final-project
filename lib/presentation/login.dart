import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // TODO create function for the authentication with firebase
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:  [
          TextField(
            decoration: const InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder() // TODO: create Border radius
              ),
            controller: email, // TODO: read more about controller
            onChanged: (val) { // TODO: UX for bad input
              print(val);

            },
          ),
           TextField(
            decoration: const InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder() // TODO: create Border radius
            ),
          controller: pass,
          ),
          ElevatedButton(
              onPressed: (){},
              child: Text("Login")
          ),
        ],
      ),
    );
  }
}
