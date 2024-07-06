import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codehub/SRC/Widgets/widgetClass.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeacherAddData extends StatefulWidget {
  final String? email;
  const TeacherAddData({super.key, this.email});

  @override
  State<TeacherAddData> createState() => _TeacherAddDataState();
}

class _TeacherAddDataState extends State<TeacherAddData> {
  late double height;
  late double width;
  TextEditingController _topicNameController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _semesterController = TextEditingController();
  TextEditingController _courseController = TextEditingController();
  File? _file;

  Future<bool> checkIfPdfExists(String topicName) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("PDFs")
        .where("topicName", isEqualTo: topicName)
        .get();

    return querySnapshot.docs.isNotEmpty;
  } catch (e) {
    print('Error checking if PDF exists: $e');
    return false;
  }
}

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
      });
    }
  }

  Future<void> uploadFile(File file) async {
    try {
      // String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      String fileName = _topicNameController.text.toString();
      String subjectName = _subjectController.text.toString();
      String semesterName = _semesterController.text.toString();
      String courseName = _courseController.text.toString();
      if (fileName.isEmpty || subjectName.isEmpty || file == null) {
        widgetClass.customDialog(context, 'Fields Required');
      } else {
        bool pdfExists = await checkIfPdfExists(fileName);
        if (pdfExists) {
        // PDF with the same topic name already exists
        widgetClass.customDialog(context, 'PDF with the same topic name already exists');
      } else {
        // Continue with the upload process

        // ... (previous code)
      }
        var userData = await FirebaseFirestore.instance
            .collection("users")
            .doc(widget.email)
            .get();

        String userName = userData['Username'];
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('$userName/pdfs/$subjectName.pdf');
        UploadTask uploadTask = storageReference.putFile(file);
        String downloadUrl = await storageReference.getDownloadURL();

        await FirebaseFirestore.instance.collection("PDFs").doc(fileName).set({
          "Pdf_Url": downloadUrl,
          "teacherName": userName,
          "topicName": fileName,
          "subjectName": subjectName,
          "Semester": semesterName,
          "Course": courseName
        });

        await uploadTask
            .whenComplete(() => print('File uploaded successfully'));
      }
    } catch (e) {
      print('Error uploading file: $e');
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
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    width: width,
                    alignment: Alignment.center,
                    child: Text(
                      'Add Data To Student',
                      style: GoogleFonts.bevan(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: 2,
                  ),
                  SizedBox(height: 35),
                  widgetClass.customTextField(
                      _topicNameController, 'Topic', false, Colors.white),
                  SizedBox(height: 40),
                  widgetClass.customTextField(
                      _subjectController, 'Subject', false, Colors.white),
                  SizedBox(height: 40),
                  widgetClass.customTextField(
                      _semesterController, 'Semester', false, Colors.white),
                  SizedBox(height: 40),
                  widgetClass.customTextField(
                      _courseController, 'Course', false, Colors.white),
                  SizedBox(height: 40),
                  widgetClass.customButtonClass('Select PDF', () async {
                    await _pickPDF(); // Call _pickPDF to select the PDF
                    if (_file != null) {
                      // If a PDF is selected, upload it to Firebase Storage
                      await uploadFile(_file!);
                      // You can add further logic or show a message after the upload
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(_subjectController.text.toString() !=
                                      null &&
                                  _topicNameController.text.toString() != null
                              ? 'File uploaded successfully'
                              : ''),
                        ),
                      );
                    }
                  }, Colors.white, Colors.black),
                  SizedBox(height: 40),
                ],
              ),
            ),
          )),
    );
  }
}
