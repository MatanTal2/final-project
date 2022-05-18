import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = true;

  @override
  void initState() {
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "Register",
              style: TextStyle(
                color: Colors.amber,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                hintText: "Email",
                prefixIcon: Icon(
                  Icons.mail,
                  color: Colors.black,
                ),
                border: OutlineInputBorder() // TODO: create Border radius
                ),
            controller: _emailController, // TODO: read more about controller
            onChanged: (val) {
              // TODO: UX for bad input
              print(val);
            },
          ),
          const SizedBox(
            height: 12.0,
          ),
          TextField(
            obscureText: _passwordVisible,
            decoration: InputDecoration(
                hintText: "Password",
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                    icon: Icon(_passwordVisible
                        ? Icons.visibility_off
                        : Icons.visibility)),
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                border: const OutlineInputBorder() // TODO: create Border radius
                ),
            controller: _passwordController,
          ),
          const SizedBox(
            height: 12.0,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
            child: Text(
              "Already register? signIn",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(
            height: 88.0,
          ),
        ],
      ),
    );
  }
}
