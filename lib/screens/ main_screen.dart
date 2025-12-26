import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/screens/completed_tasks_screen.dart';
import 'package:tasky/screens/home_screen.dart';
import 'package:tasky/screens/profile_screen.dart';
import 'package:tasky/screens/tasks_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    TasksScreen(),
    CompletedTasksScreen(),
    ProfileScreen(),
  ];
  int _currentScreen = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentScreen,
        onTap: (value) => setState(() {
          _currentScreen = value;
        }),
        items: [
          BottomNavigationBarItem(
            icon: _bulidSvgPicture("assets/images/home.svg", 0),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: _bulidSvgPicture("assets/images/to_do.svg", 1),
            label: "To Do",
          ),
          BottomNavigationBarItem(
            icon: _bulidSvgPicture("assets/images/to_do_Completed.svg", 2),
            label: "Completed",
          ),
          BottomNavigationBarItem(
            icon: _bulidSvgPicture("assets/images/profile.svg", 3),
            label: "Profile",
          ),
        ],
      ),
      body: SafeArea(child: _screens[_currentScreen]),
    );
  }

  SvgPicture _bulidSvgPicture(String path, int index) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        _currentScreen == index ? Color(0xff15B86C) : Color(0xffC6C6C6),
        BlendMode.srcIn,
      ),
    );
  }
}
