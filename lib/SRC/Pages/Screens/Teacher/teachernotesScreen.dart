import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';

class TeacherNotesScreen extends StatefulWidget {
  const TeacherNotesScreen({Key? key});

  @override
  State<TeacherNotesScreen> createState() => _TeacherNotesScreenState();
}

class _TeacherNotesScreenState extends State<TeacherNotesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1b1b1b),
      appBar: AppBar(
        title: Text('Teacher Notes'),
        actions: [IconButton(onPressed: (){
          
        }, 
        icon: Icon(FontAwesomeIcons.filter,size: 24,color: Colors.white,))],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('PDFs').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                return Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Topic: ${data["topicName"]}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Subject: ${data["subjectName"]}'),
                      Text('Semester: ${data["Semester"]}'),
                      Text('Course: ${data["Course"]}'),
                      Text('Teacher: ${data["teacherName"]}'),
                      Text('url: ${data["pdfUrl"]}'),
                      ElevatedButton(
                        onPressed: () {
                          // Handle button press for opening the PDF
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PdfViewScreen(),
                            ),
                          );
                        },
                        child: Text('Open PDF'),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return Center(
            child: Text('No notes available.'),
          );
        },
      ),
      
    );
  }
}

class PdfViewScreen extends StatelessWidget {

  const PdfViewScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PDFView(
        filePath:
            'https://firebasestorage.googleapis.com/v0/b/deb-course-ad081.appspot.com/o/Soham%2Fpdfs%2Fgdghwh.pdf?alt=media&token=6eeb61d5-9d28-48ac-be02-6490b50fe8c6',
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            fitPolicy: FitPolicy.WIDTH,

      ),
    );
  }
}
