import 'package:final_project/presentation/login.dart';
import 'package:final_project/presentation/register.dart';
import 'package:flutter/material.dart';

class Authentication extends StatelessWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const LoginScreen()

                  ),);
                },
                child: const Text(
                  "login"
                ),),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const RegisterPage()
                  ),);
                },
                child: const Text("register"),
            )
          ],
        ),
      ),
    );
  }
}
