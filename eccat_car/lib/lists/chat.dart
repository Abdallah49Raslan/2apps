import 'package:eccat_car/core/text_style.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../core/colors.dart';

class HelpPage extends StatelessWidget {
  final List<Question> questions = [
    Question('what kind of apps is this application?',
        'It is a driver assistant and car management app that allows you to keep track of basically everything.'),
    // Rest of the questions and answers
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Help Page',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: Scaffold(
        backgroundColor: blackBG,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: backgroundColorDark,
          title: const Text(
            "Help",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: whiteText,
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: EdgeInsets.all(10.0),
              child: ListTile(
                title: Text(
                  questions[index].question,
                  style: headline2,
                ),
                onTap: () {
                  _showAnswer(context, questions[index]);
                },
              ),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 50.0,
            child: InkWell(
              onTap: () {
                _sendEmail(context);
              },
              child: Center(
                child: Text(
                  'Contact Us',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showAnswer(BuildContext context, Question question) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(question.question),
          content: Text(question.answer),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _sendEmail(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      final String userEmail = user.email ?? ''; // Fetch the user's email from Firebase

      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'eccat421@gmail.com',
        queryParameters: {
          'subject': 'Help Request',
          'from': userEmail,
        },
      );

      if (await canLaunch(emailLaunchUri.toString())) {
        await launch(emailLaunchUri.toString());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No email app found.'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User is not logged in.'),
        ),
      );
    }
  }
}

class Question {
  final String question;
  final String answer;

  Question(this.question, this.answer);
}
