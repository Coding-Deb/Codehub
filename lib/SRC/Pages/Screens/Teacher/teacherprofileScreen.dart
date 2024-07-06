import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeacherProfileScreen extends StatefulWidget {
  final String? role;
  final String? email;
  const TeacherProfileScreen({super.key, this.role, this.email});

  @override
  State<TeacherProfileScreen> createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> {
  String role = ""; // Initialize role variable
  String userName = ""; // Initialize role variable
  late double height;
  late double width;

  @override
  void initState() {
    super.initState();
    getUserData(); // Call the function to fetch user data
  }

  getUserData() async {
    try {
      var userData = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.email)
          .get();

      // Check if the document exists before accessing data
      if (userData.exists) {
        setState(() {
          userName = userData['Username'];
          role = userData['Role'];
        });
      } else {
        print("User data not found for email: ${widget.email}");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff1b1b1b),
        body: Container(
          height: height,
          width: width,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text(
              //   '$role',
              // ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/No_User.png',
                    height: 100,
                    width: 100,
                  ),
                  Text(
                    '$userName \n Role: $role',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.bebasNeue(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 2),
                  ),
                ],
              ),
              Container(
                color: Colors.white54,
                height: 2,
              ),
              Container(
                width: width,
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Students List',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.actor(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
