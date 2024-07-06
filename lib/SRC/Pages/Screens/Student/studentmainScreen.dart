import 'package:codehub/SRC/Pages/Screens/Student/studentcourseScreen.dart';
import 'package:codehub/SRC/Pages/Screens/Student/studenthomeScreen.dart';
import 'package:codehub/SRC/Pages/Screens/Student/studentnotesScreen.dart';
import 'package:codehub/SRC/Pages/Screens/Student/studentprofileScreen.dart';
import 'package:flutter/material.dart';

class StudentMainScreen extends StatefulWidget {
  final String? role;
  final String? email;
  const StudentMainScreen({super.key, this.role, this.email});

  @override
  State<StudentMainScreen> createState() => _StudentMainScreenState();
}

class _StudentMainScreenState extends State<StudentMainScreen> {
   int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
  final List<Widget> _screens = [
    StudentHomeScreen(),
    StudentCourseScreen(),
    StudentNotesScreen(),
    StudentProfileScreen(email: widget.email,role: widget.role,),
  ];
    return Scaffold(
      backgroundColor: Color(0xff1b1b1b),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xffadde7a),
        unselectedItemColor: Colors.grey,
        backgroundColor: Color(0xff1b1b1b),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Course',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}