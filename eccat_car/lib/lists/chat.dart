import 'package:eccat_car/core/text_style.dart';
import 'package:flutter/material.dart';

import '../core/colors.dart';

class HelpPage extends StatelessWidget {
  final List<Question> questions = [
    Question('How do I create a new post?',
        'To create a new post, click on the "Create Post" button on the home page.'),
    Question('How can I change my profile picture?',
        'To change your profile picture, go to your profile page and click on the "Edit Profile" button.'),
    Question('How do I add a friend?',
        'To add a friend, go to their profile page and click on the "Add Friend" button.'),
    // Add more questions and answers here
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
}

class Question {
  final String question;
  final String answer;

  Question(this.question, this.answer);
}
