import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:protofilio/Screens/Profile_Screen.dart';
import 'package:protofilio/Screens/cpmpleated_screen.dart';
import 'package:protofilio/Screens/home_screen.dart';
import 'package:protofilio/Screens/todo_screen.dart';
import 'package:protofilio/Shared/colors.dart';

class MainScren extends StatefulWidget {
  const MainScren({super.key});

  @override
  State<MainScren> createState() => _MainScrenState();
}

class _MainScrenState extends State<MainScren> {
  var selescteindex = 0;
  List<Widget> screen = [
    HomeScreen(),
    TodoScreen(),
    CompleatedScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            selescteindex = value;
          });
        },
        currentIndex: selescteindex,

        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: 'To Do',
            icon: Icon(Icons.assignment_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Completed',
            icon: Icon(Icons.assignment_turned_in_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person_outline),
          ),
        ],
      ),
      body: SafeArea(child: screen[selescteindex]),
    );
  }
}
