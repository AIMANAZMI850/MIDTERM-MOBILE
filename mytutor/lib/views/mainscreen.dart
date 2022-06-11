import 'package:flutter/material.dart';
import 'package:mytutor/views/favourite.dart';
import 'package:mytutor/views/profile.dart';
import 'package:mytutor/views/subjects.dart';
import 'package:mytutor/views/subscribe.dart';
import 'package:mytutor/views/tutors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const Subjects(),
    const Tutors(),
    const Profile(),
    const Subscribe(),
    const Favourite(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Subjects',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Tutors',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions),
            label: 'Subscribe',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
            backgroundColor: Colors.purple,
          ),
        ],
        selectedItemColor: Colors.amber[800],
      ),
    );
  }
}
