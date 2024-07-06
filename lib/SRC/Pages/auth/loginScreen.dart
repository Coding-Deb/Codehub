import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codehub/SRC/Pages/Screens/Student/studentmainScreen.dart';
import 'package:codehub/SRC/Pages/Screens/Teacher/teachermainScreen.dart';
// import 'package:codehub/SRC/Pages/Screens/homeScreen.dart';
import 'package:codehub/SRC/Pages/auth/registerScreen.dart';
import 'package:codehub/SRC/Widgets/widgetClass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;

  void _showLoading() {
    setState(() {
      isLoading = true;
    });
  }

  void _hideLoading() {
    setState(() {
      isLoading = false;
    });
  }

  Login(String email, String password) async {
    if (_emailController.text == '' || _passwordController.text == '') {
      return widgetClass.customDialog(context, 'Required Data Not Filled');
    } else {
      _showLoading(); // Show loading indicator

      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        _hideLoading(); // Hide loading indicator
        print('User Logged');
        widgetClass.customDialog(context, 'User Logged');
        // DocumentSnapshot snapshot = await FirebaseFirestore.instance
        //     .collection("users")
        //     .doc(email)
        //     .get();
        // if (snapshot.exists) {
        //   return snapshot.data();
        //   print(snapshot.data());
        // } else {
        //   return 'Student'; // Default role if data not found
        // }
        var userData = await FirebaseFirestore.instance
              .collection("users")
              .doc(email)
              .get();
        

          String role = userData['Role'];
          String username = userData['Username'];
          print({role,username});
          

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => TeachMainScreen()),
        // );

      if (role == 'Teacher') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TeachMainScreen(email: email,role: role,)),
            );
          } else {
            // Navigate to the default home screen for other roles
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => StudentMainScreen(email: email,role: role,)),
            );
          }

      } on FirebaseAuthException catch (e) {
        _hideLoading(); // Hide loading indicator
        print(e.code.toString());
        // Handle error (e.g., show an error message to the user)
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1b1b1b),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LottieBuilder.network(
                'https://lottie.host/9195d9cf-7524-4b11-b03e-ebad0843a8eb/F76thPgX0N.json',
                height: 320,
                width: 240,
              ),
              SizedBox(height: 35),
              widgetClass.customTextField(
                _emailController,
                'Email',
                false,
                Colors.white,
              ),
              SizedBox(
                height: 35,
              ),
              widgetClass.customTextField(
                _passwordController,
                'Password',
                true,
                Colors.white,
              ),
              SizedBox(height: 35),
              widgetClass.customButtonClass('Login', () {
                Login(_emailController.text, _passwordController.text);
              }, Color(0xffadde7a), Color(0xff1b1b1b)),
              SizedBox(
                height: 32,
              ),
              isLoading
                  ? CircularProgressIndicator() // Show loading indicator
                  : GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Don't Have Any Account? \n Register Here",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.libreBaskerville(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
