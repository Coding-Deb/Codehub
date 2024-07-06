import 'package:codehub/SRC/Pages/Screens/Teacher/addData.dart';
import 'package:codehub/SRC/Pages/Screens/Teacher/teachercourseScreen.dart';
import 'package:codehub/SRC/Pages/Screens/Teacher/teacherhomeScreen.dart';
import 'package:codehub/SRC/Pages/Screens/Teacher/teachernotesScreen.dart';
import 'package:codehub/SRC/Pages/Screens/Teacher/teacherprofileScreen.dart';
import 'package:flutter/material.dart';

class TeachMainScreen extends StatefulWidget {
  final String? role;
  final String? email;
  const TeachMainScreen({Key? key, this.role, this.email}) : super(key: key);

  @override
  State<TeachMainScreen> createState() => _TeachMainScreenState();
}

class _TeachMainScreenState extends State<TeachMainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
  

  final List<Widget> _screens = [
    TeacherHomeScreen(),
    TeacherCourseScreen(),
    TeacherAddData(email: widget.email),
    TeacherNotesScreen(),
    TeacherProfileScreen(email: widget.email,role: widget.role,),
  ];
    var userEmail = widget.email;
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
            icon: Icon(Icons.home,size: 24,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school,size: 24,), 
            label: 'Course',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle,size: 42,color: Color(0xffadde7a),), 
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note,size: 24,),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,size: 24,),
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