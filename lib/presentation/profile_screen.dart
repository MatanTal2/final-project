import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {

    Future<void> _signOut() async {
      await FirebaseAuth.instance.signOut();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("profile"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text("data"),),
            ListTile(
              title: const Text("Logout"),
              onTap: _signOut
            ),
          ],
        ),
      ),
      body: Center(child: Text("Profile screen")),
    );
  }
}
