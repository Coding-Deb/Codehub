import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({super.key});

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  late double height;
  late double width;

  String getDayName() {
    DateTime now = DateTime.now();
    return DateFormat('EEEE').format(now); // 'EEEE' represents the full day name
  }

  String getGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff1b1b1b),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: width,
                  child: Text(
                    '${getGreeting()},',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.actor(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
