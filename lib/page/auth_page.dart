import 'package:final_project/widget/login_widget.dart';
import 'package:final_project/widget/signup_widget.dart';
import 'package:flutter/cupertino.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginWidget(
          onClickSignUp: toggle,
        )
      : SignUpWidget(
          onClickSignIn: toggle,
        );

  void toggle() => setState(() => isLogin = !isLogin);
}
