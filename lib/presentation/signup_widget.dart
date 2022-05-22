import 'package:email_validator/email_validator.dart';
import 'package:final_project/presentation/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickSignIn;

  const SignUpWidget({
    Key? key,
    required this.onClickSignIn,
  }) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60.0,
              ),
              const FlutterLogo(
                size: 120,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                "Welcome Back",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0,
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              TextFormField(
                controller: _emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "email",
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        : null,
              ),
              const SizedBox(
                height: 4.0,
              ),
              TextFormField(
                controller: _passwordController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: "password"),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6   //Todo: create password validator function
                    ? 'Enter minimum, 6 digits'
                    : null,
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  maximumSize: const Size.fromHeight(50.0),
                ),
                onPressed: signUp,
                icon: const Icon(
                  Icons.arrow_forward,
                  size: 32.0,
                ),
                label: const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              RichText(
                text: TextSpan(
                  text: "No Account? ",
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickSignIn,
                      text: "Sign In",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}