import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/colors.dart';
import '../../core/globalvariables.dart';
import 'HealthConditions.dart';

class Passenger2 extends StatefulWidget {
  const Passenger2({super.key});

  @override
  State<Passenger2> createState() => _Passenger2State();
}

class _Passenger2State extends State<Passenger2> {
  final database = FirebaseDatabase.instance.reference();
  late StreamSubscription outputstream;

  void initState() {
    super.initState();
    activateListeners();
  }

  void activateListeners() {
    outputstream = database.child('HealthDatabase').onValue.listen((event) {
      //Passenger1 values
      final num? P2heartRate =
          event.snapshot.child('passenger2heartRate').value as num;
      final num? P2temperature =
          event.snapshot.child('passenger2temperature').value as num;
      final num? P2oximeter =
          event.snapshot.child('passenger2oximeter').value as num;

      setState(() {
        P2displaytemp = P2temperature!;
        P2displayheartRate = P2heartRate!;
        P2displayoximeter = P2oximeter!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double childAspectvalue = 2;
    double Titlefontsize = 20;
    double Iconvalue = 30;
    double normalfontsize = 25;
    double infofontsize = 20;
    if (screenWidth > 480) {
      // If width is more than 480, set a new font value
      childAspectvalue = 2.5;
      Titlefontsize = 35;
      Iconvalue = 40;
      normalfontsize = 30;
      infofontsize = 25;
    }
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: backgroundColorDark,
          title: const Text(
            "Healthcare",
            style: headline1,
          ),
          iconTheme: IconThemeData(color: whiteText),
        ),
        body: Container(
            width: screenWidth,
            height: screenHeight - 70,
            padding: EdgeInsets.only(top: 30, right: 10, left: 10),
            decoration: BoxDecoration(
              image: DecorationImage(
                  // fit: BoxFit.fill,
                  image: AssetImage("assets/icons/Car.png")),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                SizedBox(
                  height: 25,
                ),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(10),
                    child: GridView(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: childAspectvalue,
                      ),
                      children: [
                        //HeartRate
                        Container(
                          padding:
                              EdgeInsets.only(right: 10, left: 10, top: 10),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            border: Border.all(color: borderColor, width: 2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Heart Rate",
                                    style: TextStyle(
                                        fontSize: Titlefontsize,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Spacer(),
                                  Positioned(
                                    top: 10,
                                    right: 6,
                                    child: SvgPicture.asset(
                                      "assets/icons/heart-rate.svg",
                                      height: Iconvalue,
                                      width: Iconvalue,
                                      color: Colors.red,
                                    ),
                                  ),
                                  /*SvgPicture.asset("assets/icons/heart-rate.svg",
                        height: 20, width: 20, color: Colors.red),*/
                                ],
                              ),
                              SizedBox(height: 25),
                              Row(
                                children: [
                                  Text(
                                    '$P2displayheartRate',
                                    style: TextStyle(
                                      fontSize: normalfontsize,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    " BPM",
                                    style: TextStyle(
                                      fontSize: normalfontsize,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [P2HeartRateCondition()],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "60  : 100\nNormal",
                                          style: TextStyle(
                                            fontSize: infofontsize,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  ])
                            ],
                          ),
                        ),

                        Container(
                          padding:
                              EdgeInsets.only(right: 10, left: 10, top: 10),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            border: Border.all(color: borderColor, width: 2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Temperature",
                                    style: TextStyle(
                                        fontSize: Titlefontsize,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Spacer(),
                                  Positioned(
                                    top: 10,
                                    right: 6,
                                    child: SvgPicture.asset(
                                      "assets/icons/temperature-high-solid-svgrepo-com.svg",
                                      height: Iconvalue,
                                      width: Iconvalue,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  /*SvgPicture.asset("assets/icons/heart-rate.svg",
                        height: 20, width: 20, color: Colors.red),*/
                                ],
                              ),
                              SizedBox(height: 25),
                              Row(
                                children: [
                                  Text(
                                    '$P2displaytemp',
                                    style: TextStyle(
                                      fontSize: normalfontsize,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    " °C",
                                    style: TextStyle(
                                      fontSize: normalfontsize,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [P2TemperatureCondition()],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "36  : 37.2\nNormal",
                                          style: TextStyle(
                                            fontSize: infofontsize,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  ])
                            ],
                          ),
                        ),

                        Container(
                          padding:
                              EdgeInsets.only(right: 10, left: 10, top: 10),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            border: Border.all(color: borderColor, width: 2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Oximeter",
                                    style: TextStyle(
                                        fontSize: Titlefontsize,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Spacer(),
                                  Positioned(
                                    top: 10,
                                    right: 6,
                                    child: Image.asset(
                                      "assets/icons/oxi3.png",
                                      height: Iconvalue,
                                      width: Iconvalue,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  /*SvgPicture.asset("assets/icons/heart-rate.svg",
                        height: 20, width: 20, color: Colors.red),*/
                                ],
                              ),
                              SizedBox(height: 25),
                              Row(
                                children: [
                                  Text(
                                    '$P2displayoximeter',
                                    style: TextStyle(
                                      fontSize: normalfontsize,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    " SPO2",
                                    style: TextStyle(
                                      fontSize: normalfontsize,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [P2OximeterCondition()],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "90  : 100\nNormal",
                                          style: TextStyle(
                                            fontSize: infofontsize,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  ])
                            ],
                          ),
                        ),
                      ],
                    ))
              ]),
            )));
  }

  void deactivate() {
    outputstream.cancel();
    super.deactivate();
  }
}
