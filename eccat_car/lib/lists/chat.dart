import 'package:eccat_car/core/text_style.dart';
import 'package:flutter/material.dart';

import '../core/colors.dart';

class HelpPage extends StatelessWidget {
  final List<Question> questions = [
    Question('what kind of apps is this application?',
        'It is a driver assistant and car management app that allow you to keep track of basically everything.'),
    Question('How can I change my profile picture?',
        'To change your profile picture, go to User Info page and click on the "Edit Profile" button.'),
    Question('What services does the application provide?',
        'This application provide Security services, healthcare services, AI services and IOT services.'),
    Question('How do I reset my password?',
        'To reset your password, go to the login page and click on the "Forgot Password" link. or go to User Info page and click on "Chang Password"'),
    Question('What security services does the application provide?',
        'Identify the driver of the vehicle.If the driver is authorized, the entered user data is sent accordingly.If the driver is not authorized,captures the photo of driver and sends it to the owner for verification.'),
    Question('What Healthcare services does the application provide?',
        'Health tracking for Driver and each passenger in the car to keep track of Heart rate,Temperature,Oximeter,Alcohol detection,Display these vital values on applicationand and give alert if any value is abnormal.'),
    Question('What IOT services does the application provide?',
        'Display the current state of vehicle speed, battery charge, seat belt and warn the driver if anything went wrong.'),
    Question('What AI services does the application provide?',
        'Alert the driver if he gets out the lane or bump detected '),
    Question('What services does the application provide to  the customer?',
        'Before getting into the car, the customer can know who the current driver of the car is, make sure of his health condition, that he is not infected with the Corona virus, and make sure that the driver is conscious not drunk.  After getting into the car, the customer is provided with some data about his health like heart rate, temperature and oximeter. '),
    Question('What services does the application provide to  the driver?',
        'first,Health tracking for Driver and each passenger in the car and give alert if any value is abnormal. second,Display the current state of vehicle speed, battery charge, seat belt and warn the driver if anything went wrong.finally,alert the driver if he gets out the lane or bump detected '),
    Question('What services does the application provide to  the owner?',
        'Enables the owner to track everything in the car and verify the identity of the current driver and that he is conscious not dtunk. and monitor the components of the car and the health status of the driver and passengers'),
    // Add more questions and answers here
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 480;
    return Scaffold(
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
                style: isLargeScreen
                    ? headline2.copyWith(fontSize: 30)
                    : headline2,
              ),
              onTap: () {
                _showAnswer(context, questions[index]);
              },
            ),
          );
        },
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
