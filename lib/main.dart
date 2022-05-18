import 'package:final_project/presentation/authentication.dart';
import 'package:final_project/presentation/login.dart';
import 'package:final_project/presentation/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:final_project/presentation/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthTypeSelector(),
    );
  }
}

class AuthTypeSelector extends StatefulWidget {
  const AuthTypeSelector({Key? key}) : super(key: key);

  @override
  State<AuthTypeSelector> createState() => _AuthTypeSelectorState();
}

class _AuthTypeSelectorState extends State<AuthTypeSelector> {
  bool isConnect = true;
  // Navigates to a new page
  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context) /*!*/ .push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Name of the app'),
      ),
      body: LayoutBuilder(builder: (context, constraints){
        return Row(
          children: [
            Visibility(
                visible: constraints.maxWidth >= 1200,
                child: Expanded(
                  child: Container(
                    height: double.infinity,
                    color: Theme.of(context).colorScheme.primary,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("data",
                          style: Theme.of(context).textTheme.headline4,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
            ),
            SizedBox(
              width: constraints.maxWidth >= 1200 ? constraints.maxWidth / 2 : constraints.maxWidth,
              child: StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot){
                    if (snapshot.hasData) {
                      print("size box");
                      return const ProfileScreen();
                    }
                    return const Authentication();
                  },
              ),
            ),
          ],
        );
      }),
    );
  }
}

class HomePag extends StatefulWidget {
  const HomePag({Key? key}) : super(key: key);

  @override
  State<HomePag> createState() => _HomePagState();
}

class _HomePagState extends State<HomePag> {
  // This widget is the root of your application.
  // Initialize Firebase App
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
