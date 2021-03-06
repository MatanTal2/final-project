import 'dart:developer';
import 'package:email_validator/email_validator.dart';
import 'package:final_project/presentation/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../presentation/forgot_password_page.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickSignUp;

  const LoginWidget({Key? key, required this.onClickSignUp}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = true;

  @override
  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _isPasswordVisible = true;
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
                        ? 'Enter valid email'
                        : null,
              ),
              const SizedBox(
                height: 4.0,
              ),
              TextFormField(
                controller: _passwordController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "password",
                  suffixIcon: IconButton(
                      onPressed: () {
                        changePasswordVisibility();
                      },
                      icon: Icon(_isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility),
                      color: _isPasswordVisible
                          ? Colors.white30
                          : Colors.redAccent),
                ),
                obscureText: _isPasswordVisible,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length > 6
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
                onPressed: signIn,
                icon: const Icon(
                  Icons.arrow_forward,
                  size: 32.0,
                ),
                label: const Text(
                  "Sign In",
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              GestureDetector(
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 15.0,
                  ),
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ForgotPasswordPage(),
                )),
              ),
              const SizedBox(height: 8.0,),
              RichText(
                text: TextSpan(
                  text: "No Account? ",
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickSignUp,
                      text: "Sign Up",
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

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      log('data: $e');

      Utils.showSnackBar(e.message, Colors.red);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  void changePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }
}
