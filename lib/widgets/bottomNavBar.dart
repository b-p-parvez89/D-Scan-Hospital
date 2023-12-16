import 'package:d_scan_hospital/screen/homePage.dart';
import 'package:flutter/material.dart';

import '../screen/profilePage.dart';

class BoottomNavBar extends StatefulWidget {
  const BoottomNavBar({super.key});

  @override
  State<BoottomNavBar> createState() => _BoottomNavBarState();
}

class _BoottomNavBarState extends State<BoottomNavBar> {
  int _currentIndex = 0;

  // Widgets for each tab
  final List<Widget> pages = [
    HomePage(),
    Container(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Tab 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Tab 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tab 3',
          ),
        ],
      ),
    );
  }
}
