import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentProfileScreen extends StatefulWidget {
  final String? role;
  final String? email;
  const StudentProfileScreen({super.key, this.role, this.email});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  String role = ""; // Initialize role variable
  String userName = ""; // Initialize role variable

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff1b1b1b),
        body: Container(
           height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text(
              //   '$role',
              // ),
              Container(
                alignment: Alignment.topLeft,
                color: Colors.red,
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Image.asset('assets/images/No_User.png',height: 70,width: 70,),
                    SizedBox(width: 30,),
                    Text(
                      '$userName',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bebasNeue(
                          fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white,letterSpacing: 2
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12,),
              Container(
                child: Text(
                  '$userName \n $role',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bebasNeue(
                      fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white,letterSpacing: 2
                      ),
                ), // Display the role
              ),
            ],
          ),
        ),
      ),
    );
  }
}
