import 'package:final_project/presentation/auth_page.dart';
import 'package:final_project/presentation/authentication.dart';
import 'package:final_project/presentation/home_page.dart';
import 'package:final_project/presentation/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyAp());
}
final navigatorKey = GlobalKey<NavigatorState>();

class MyAp extends StatelessWidget {
  const MyAp({Key? key}) : super(key: key);
  static const String title = 'Speech to text';

  @override
  Widget build(BuildContext context) => MaterialApp(
    navigatorKey: navigatorKey,
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.teal,
      ),
    ),
    home: const MainPage(),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Navigates to a new page
  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context) /*!*/ .push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isConnect = true;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Name of the app'),
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("size box");
            return const ProfileScreen();
          }
          return const Authentication();
        },
      ),
    );
  }
}


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //optional
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong!"),
              );
            } else if (snapshot.hasData) {
              return const HomePage();
            } else {
              return const AuthPage();
            }
          },
        ),
      );
}
