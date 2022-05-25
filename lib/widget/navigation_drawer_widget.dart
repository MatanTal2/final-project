import 'package:final_project/page/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../page/about_page.dart';
import '../page/user_page.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);
  final padding = const EdgeInsets.symmetric(horizontal: 20.0);

  @override
  Widget build(BuildContext context) {
    const _name = 'Person Name';
    const _email = 'abc@gmail.com';
    const _urlImage =
        'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?ixlib=rb-1.2.1&raw_url=true&q=80&fm=jpg&crop=entropy&cs=tinysrgb&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928';

    return Drawer(
      child: Material(
        color: Colors.amber[700],
        child: ListView(
          children: [
            buildHeader(
              urlImage: _urlImage,
              name: _name,
              email: _email,
              onClicked: () =>
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          const UserPage(
                            name: _name,
                            urlImage: _urlImage,
                          ))),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(
                    height: 48.0,
                  ),
                  buildMenuItem(
                      text: 'About',
                      icon: Icons.info,
                      onClicked: () => selectedItem(context, 0)),
                  const SizedBox(
                    height: 8.0,
                  ),
                  buildMenuItem(text: 'Item 2', icon: Icons.propane),
                  const SizedBox(
                    height: 8.0,
                  ),
                  buildMenuItem(text: 'Log out', icon: Icons.logout,
                  onClicked: () => selectedItem(context, 2)),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Divider(
                    color: Colors.white70,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    const color = Colors.white;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(text),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const AboutPage(),
        ));
        break;
      case 2:
        signOutUser();
        //navigatorKey.currentState!.popUntil((route) => route.isFirst);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MainPage(),
        ));
        break;
    }
  }

  buildHeader({required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked}) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40.0)),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(urlImage),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    email,
                    style: const TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                width: 10.0,
              ),
            ],
          ),
        ),
      );

  Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}
