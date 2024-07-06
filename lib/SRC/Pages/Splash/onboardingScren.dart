import 'package:codehub/SRC/Pages/auth/loginScreen.dart';
import 'package:codehub/SRC/Widgets/widgetClass.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late double height;
  late double width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
        // appBar: AppBar(title: Text('Onboarding')),
        backgroundColor: Color(0xff1b1b1b),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LottieBuilder.network(
                'https://lottie.host/5bf59782-aa19-4337-a5c0-7cad45976123/zrtp7kymVI.json',
                height: 350,
                width: 280,
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Knowledge Is Power \n Code Is Future",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 33,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              widgetClass.customButtonClass('Get Started', () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }, Color(0xffadde7a), Color(0xff1b1b1b))
            ],
          ),
        ));
  }
}
