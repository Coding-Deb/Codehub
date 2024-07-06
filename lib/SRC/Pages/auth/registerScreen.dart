import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codehub/SRC/Pages/auth/loginScreen.dart';
import 'package:codehub/SRC/Widgets/widgetClass.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _selectedRole = 'Student'; // Default role

  List<String> _roles = ['Student', 'Teacher']; // Dropdown items

  @override
  Widget build(BuildContext context) {
    Register(String email, String password , String username) async {
      if (email == '' || password == '') {
        return widgetClass.customDialog(context, 'Required Data Not Filled');
      } else {
        UserCredential? userCredential;
        try {
          userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((value) {
            print('User Created');
            widgetClass.customDialog(context, 'User Created');
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          });
          await FirebaseFirestore.instance.collection("users").doc(email).set({
            "Username": username,
            "Email": email,
            "Role": _selectedRole
          }).then((value){
            print('Data Added to Firestore');
          });
        } on FirebaseAuthException catch (e) {
          print(e.code.toString());
        }
      }
    }

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
                'https://lottie.host/49af21fc-46ca-4694-ae24-f2def329053e/A66LSmwF9B.json',
                height: 320,
                width: 240,
              ),
              SizedBox(height: 35),
               widgetClass.customTextField(
                  _usernameController, 'Username', false, Colors.white),
              SizedBox(
                height: 35,
              ),
              widgetClass.customTextField(
                  _emailController, 'Email', false, Colors.white),
              SizedBox(
                height: 35,
              ),
              widgetClass.customTextField(
                  _passwordController, 'Password', true, Colors.white),
              SizedBox(height: 35),
              DropdownButton<String>(
                value: _selectedRole,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRole = newValue!;
                  });
                },
                items: _roles.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                style: TextStyle(color: Colors.white),
                dropdownColor: Color(0xff1b1b1b),
              ),
              SizedBox(
                height: 32,
              ),
              widgetClass.customButtonClass('Register', () {
                Register(_emailController.text, _passwordController.text,_usernameController.text);
              }, Color(0xffadde7a), Color(0xff1b1b1b)),
              // Other widgets...
              SizedBox(height: 35),
              // Dropdown list for selecting role
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text(
                  "Already Have Accouunt? \n Login Here",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.libreBaskerville(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
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
