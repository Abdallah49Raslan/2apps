import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eccat_car/core/colors.dart';
import 'package:eccat_car/core/globalvariables.dart';
import 'package:eccat_car/Pages/Health Care/HealthConditions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

class Driverinfo extends StatefulWidget {
  const Driverinfo({super.key});

  @override
  State<Driverinfo> createState() => _DriverinfoState();
}

class _DriverinfoState extends State<Driverinfo> {
  final database = FirebaseDatabase.instance.reference();
  late StreamSubscription outputstream;

  void initState() {
    super.initState();
    activateListeners();
  }

  void activateListeners() {
    outputstream = database.child('HealthDatabase').onValue.listen((event) {
      final num? temp = event.snapshot.child('Drivertemperature').value as num;
      final num? heartRate =
          event.snapshot.child('DriverheartRate').value as num;
      final num? oximeter = event.snapshot.child('Driveroximeter').value as num;
      final Object? alcohol = event.snapshot.child('Driveralcohol').value;

      setState(() {
        Ddisplaytemp = temp!;
        DdisplayheartRat = heartRate!;
        Ddisplayoximeter = oximeter!;
        displayalcohol = '$alcohol';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(builder: (context, cons) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;
        double normalfontSize = 20;
        double titlefontSize = 25;
        double tivefontSize = 15;
        double hearticonvalue = 20;
        double tempiconvalue = 25;
        double oxiiconvalue = 35;
        double coholiconvalue = 18;
        double mainSizedBox = 5;
        double wideSizedBox = 10;
        if (screenWidth > 480) {
          // If width is more than 480, set a new font value
          normalfontSize = 30;
          titlefontSize = 35;
          tivefontSize = 30;
          hearticonvalue = 30;
          tempiconvalue = 35;
          oxiiconvalue = 45;
          coholiconvalue = 28;
          mainSizedBox = 15;
          wideSizedBox = 120;
        }
        return Container(
          width: screenWidth,
          height: (screenHeight - 70) / 4,
          padding: EdgeInsets.only(right: 5, left: 1),
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              Text(" Driver Health",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: titlefontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  //Icons Column
                  Column(
                    children: [
                      SvgPicture.asset("assets/icons/heart-rate.svg",
                          height: hearticonvalue,
                          width: hearticonvalue,
                          color: Colors.red),
                      SizedBox(
                        height: mainSizedBox,
                      ),
                      SvgPicture.asset(
                          "assets/icons/temperature-high-solid-svgrepo-com.svg",
                          height: tempiconvalue,
                          width: tempiconvalue,
                          color: Colors.orange),
                      SizedBox(
                        height: mainSizedBox,
                      ),
                      Image.asset(
                        "assets/icons/oxi3.png",
                        height: oxiiconvalue,
                        width: oxiiconvalue,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: mainSizedBox,
                      ),
                      Image.asset("assets/icons/alcohol.png",
                          height: coholiconvalue,
                          width: coholiconvalue,
                          color: Color.fromARGB(255, 43, 168, 5)),
                    ],
                  ),
                  //Label Column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Heart Rate",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: normalfontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: mainSizedBox,
                      ),
                      Text(
                        "Temp",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: normalfontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: mainSizedBox,
                      ),
                      Text(
                        "Oximeter",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: normalfontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: mainSizedBox,
                      ),
                      Text(
                        "Alcohol",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: normalfontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: wideSizedBox,
                  ),
                  //Values Column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '$DdisplayheartRat',
                        style: TextStyle(
                          fontSize: normalfontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: mainSizedBox,
                      ),
                      Text(
                        '$Ddisplaytemp',
                        style: TextStyle(
                          fontSize: normalfontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: mainSizedBox,
                      ),
                      Text(
                        '$Ddisplayoximeter',
                        style: TextStyle(
                          fontSize: normalfontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: mainSizedBox,
                      ),
                      Text(
                        "$displayalcohol",
                        //displayalcohol == 'Negative' ? '-Ve' : '+Ve',
                        style: TextStyle(
                          fontSize: tivefontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  //Normal&Abnormal Column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DHeartRateCondition(),
                      SizedBox(
                        height: mainSizedBox,
                      ),
                      DTemperatureCondition(),
                      SizedBox(
                        height: mainSizedBox,
                      ),
                      DOximeterCondition(),
                      SizedBox(
                        height: mainSizedBox,
                      ),
                      DAlcoholCondition(),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 40,
              ),
            ],
          ),
        );
      }),
    );
  }
}
