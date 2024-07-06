import 'package:flutter/material.dart';

class TeacherCourseScreen extends StatefulWidget {
  const TeacherCourseScreen({super.key});

  @override
  State<TeacherCourseScreen> createState() => _TeacherCourseScreenState();
}

class _TeacherCourseScreenState extends State<TeacherCourseScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff1b1b1b),
        body: SingleChildScrollView(
          child: Column(
            children: [
              
            ],
          ),
        )
      ),
    );
  }
}