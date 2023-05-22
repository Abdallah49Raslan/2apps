import 'package:application_1/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:application_1/healthcare/passenger1_ui.dart';
import 'package:application_1/healthcare/passenger2_ui.dart';

class PassengerChoice extends StatefulWidget {
  const PassengerChoice({super.key});

  @override
  State<PassengerChoice> createState() => _PassengerChoiceState();
}

class _PassengerChoiceState extends State<PassengerChoice> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double seatfontsize = 20;
    double widthdivision = 3;
    double heightdivision = 15;
    if (screenWidth > 480) {
      seatfontsize = 30;
      widthdivision = 5;
      heightdivision = 20;
    }
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
            width: screenWidth,
            height: screenHeight - 70,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(top: 70, right: 10, left: 10),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                "assets/icons/Car.png",
              )),
            ),
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: LayoutBuilder(builder: (context, cons) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: (screenHeight / 3),
                        ),
                        Container(
                          height: screenHeight / heightdivision,
                          width: screenWidth / widthdivision,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white10),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(
                                      color: Color(0xffA8E0F1), width: 2),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) =>
                                          const passenger1_ui()));
                            },
                            child: Text(
                              "Seat 1",
                              style: TextStyle(
                                  color: Colors.white, fontSize: seatfontsize),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        Container(
                          height: screenHeight / heightdivision,
                          width: screenWidth / widthdivision,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white10),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(
                                      color: Color(0xffA8E0F1), width: 2),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) =>
                                          const passenger2_ui()));
                            },
                            child: Text(
                              "Seat 2",
                              style: TextStyle(
                                  color: Colors.white, fontSize: seatfontsize),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: (screenHeight / 3),
                        ),
                      ],
                    ),
                  );
                }))));
  }
}
