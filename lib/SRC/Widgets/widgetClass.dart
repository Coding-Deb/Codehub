import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class widgetClass {
  static customButtonClass(
    String title,
    VoidCallback voidCallback,
    Color? color,
    Color? textColor,
  ) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 100),
      
      child: ElevatedButton(
          onPressed: voidCallback,
          style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      padding: EdgeInsets.symmetric(vertical: 22, horizontal: 100),
                      elevation: 0,
                      shadowColor: color,
                      
                     ),
          child: Text(title,
              style: GoogleFonts.rubik(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor))),
    );
  }

  static customTextField(
    TextEditingController controller,
    String hintText,
    bool obscureText,
    Color color
  ){
    return TextField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,

        hintStyle: GoogleFonts.ptSans(
          color: color
        ),
        fillColor: Color(0xff32342f),
        contentPadding: const EdgeInsets.fromLTRB(16,8,16,8),
        border: OutlineInputBorder(borderSide: BorderSide.none),
      )
    );
  }

static customDialog(
  BuildContext context,
  String text
){
  return showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      title: Text(text),
    );
  });
}

}
