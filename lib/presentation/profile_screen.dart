import 'package:final_project/presentation/speech_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:avatar_glow/avatar_glow.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget _currentWidget = Container();
  var _currentIndex = 0;
  Widget _settingsScreen() {
    return Container(
      color: Colors.red[200],
    );
  }
   _loadScreen() {
    switch(_currentIndex) {
      case 1: return Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context)=> const SpeechScreen()));
      case 0: return setState(() => _currentWidget = _settingsScreen());
    }
  }
  @override
  void initState() {
    super.initState();
    _loadScreen();
  }

  @override
  Widget build(BuildContext context) {

    Future<void> _signOut() async {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context)=> const MyApp()));
    }
    return Scaffold(
      
      appBar: AppBar(
        title: const Text("profile"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text("data"),),
            ListTile(
              title: const Text("Logout"),
              onTap: _signOut,
            ),
          ],
        ),
      ),
      body: Center(child: Text("Profile screen")),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          _loadScreen();
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            label: 'Start record',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'history',
          ),
        ],
        //currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        //onTap: _onItemTapped,
      ),
    );
  }
}
