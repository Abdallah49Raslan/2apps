import 'dart:async';
import 'dart:math';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../core/colors.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:convert';

class IoTPage extends StatefulWidget {
  const IoTPage({super.key});

  @override
  State<IoTPage> createState() => _IoTPageState();
}

class _IoTPageState extends State<IoTPage> {
  var refdb = FirebaseDatabase.instance.ref();
  dynamic display;
  dynamic break_display;
  dynamic light_display;
  dynamic batt_display;

  sebelisteners() {}

  @override
  void initState() {
    sebelisteners();

    super.initState();
  }

  int selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    // While using transactions you can still listen to all
    // incoming messages!

    var seatbelt = refdb.child('seatbelt');
    var speed = refdb.child('speed');
    var battery = refdb.child('battery');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text("Iot",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: whiteText,
            )),
      ),
      body: Container(
        width: 600,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
            "assets/icons/Car.png",
          )),
          color: Colors.black,
        ),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              width: 350,
              decoration: BoxDecoration(color: Colors.white10),
              child: Column(children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'battery',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                    child: Expanded(
                        child: Container(
                            child: StreamBuilder(
                                stream: refdb.child('battery/batt').onValue,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    var b;
                                    double p = 0.5;
                                    b = snapshot.data?.snapshot.value;
                                    var B = double.parse(b);
                                    if (B > 20) {
                                      p = B / 100;
                                      // AwesomeNotifications().createNotification(
                                      //     content: NotificationContent(
                                      //   id: 50,
                                      //   channelKey: "schedule",
                                      //   title: "battery Alert",
                                      //   body: "battery is very low",
                                      //   notificationLayout:
                                      //       NotificationLayout.BigPicture,
                                      //   wakeUpScreen: true,
                                      //   locked: true,
                                      //   displayOnBackground: true,
                                      //   actionType: ActionType.Default,
                                      // ));
                                      return new CircularPercentIndicator(
                                        animationDuration: 4500,
                                        radius: 100.0,
                                        lineWidth: 25.0,
                                        animation: true,
                                        percent: p,
                                        center: new Text(
                                          "${B.toInt()} %",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30.0,
                                              color: Colors.white),
                                        ),
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        progressColor: Colors.green,
                                      );
                                    } else if (B <= 20) {
                                      p = B / 100;
                                      return new CircularPercentIndicator(
                                        animationDuration: 4500,
                                        radius: 100.0,
                                        lineWidth: 25.0,
                                        animation: true,
                                        percent: p,
                                        center: new Text("${B.toInt()} %",
                                            style: new TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 40.0,
                                                color: Colors.red)),
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        progressColor: Colors.red,
                                      );
                                    }
                                  }
                                  return new CircularPercentIndicator(
                                    animationDuration: 4500,
                                    radius: 100.0,
                                    lineWidth: 25.0,
                                    animation: true,
                                    percent: 0.0,
                                    center: new Text(
                                      "0 %",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30.0,
                                          color: Colors.white),
                                    ),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: Colors.green,
                                  );
                                })))),
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            Column(children: [
              Container(
                width: 350,
                decoration: BoxDecoration(color: Colors.white10),
                margin: EdgeInsets.only(bottom: 22),
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 40,
                    ),
                    child: Text(
                      'SPeed',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                  InkWell(
                      child: Container(
                          margin: EdgeInsets.only(top: 20),
                          width: 400,
                          height: 300,
                          child: Expanded(
                              child: Container(
                            child: StreamBuilder(
                                stream: refdb.child('speed/sp').onValue,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    var num;

                                    num = snapshot.data?.snapshot.value;

                                    var c = double.parse(num);

                                    if (c >= 0.5) {
                                      // AwesomeNotifications().createNotification(
                                      //     content: NotificationContent(
                                      //   id: 51,
                                      //   channelKey: "schedule",
                                      //   title: "speed Alert",
                                      //   body: "speed is very high",
                                      //   notificationLayout:
                                      //       NotificationLayout.BigPicture,
                                      //   wakeUpScreen: true,
                                      //   locked: true,
                                      //   displayOnBackground: true,
                                      //   actionType: ActionType.Default,
                                      // ));
                                      return SfRadialGauge(
                                        enableLoadingAnimation: true,
                                        animationDuration: 4500,
                                        axes: <RadialAxis>[
                                          RadialAxis(
                                            minimum: 0,
                                            maximum: 60,
                                            //  axisLineStyle:AxisLineStyle(color: Colors.white) ,
                                            axisLabelStyle: GaugeTextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),

                                            pointers: <GaugePointer>[
                                              NeedlePointer(
                                                needleColor: Colors.orange,
                                                value: c,
                                                enableAnimation: true,
                                              )
                                              //
                                            ],
                                            ranges: <GaugeRange>[
                                              GaugeRange(
                                                startValue: 0,
                                                endValue: 60,
                                                color: Colors.blue,
                                              ),
                                              GaugeRange(
                                                startValue: 60,
                                                endValue: 140,
                                                color: Colors.blue,
                                              ),
                                              GaugeRange(
                                                startValue: 140,
                                                endValue: 200,
                                                color: Colors.blue,
                                              )
                                            ],
                                            annotations: <GaugeAnnotation>[
                                              GaugeAnnotation(
                                                widget: Text(
                                                  '${c} K/H',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                positionFactor: 0.5,
                                                angle: 90,
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    }

                                    return SfRadialGauge(
                                      enableLoadingAnimation: true,
                                      animationDuration: 4500,
                                      axes: <RadialAxis>[
                                        RadialAxis(
                                          minimum: 0,
                                          maximum: 60,
                                          //  axisLineStyle:AxisLineStyle(color: Colors.white) ,
                                          axisLabelStyle: GaugeTextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),

                                          pointers: <GaugePointer>[
                                            NeedlePointer(
                                              needleColor: Colors.orange,
                                              value: num,
                                              enableAnimation: true,
                                            )
                                            //
                                          ],
                                          ranges: <GaugeRange>[
                                            GaugeRange(
                                              startValue: 0,
                                              endValue: 60,
                                              color: Colors.blue,
                                            ),
                                            GaugeRange(
                                              startValue: 60,
                                              endValue: 140,
                                              color: Colors.blue,
                                            ),
                                            GaugeRange(
                                              startValue: 140,
                                              endValue: 200,
                                              color: Colors.blue,
                                            )
                                          ],
                                          annotations: <GaugeAnnotation>[
                                            GaugeAnnotation(
                                              widget: Text(
                                                '${c} K/H',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              positionFactor: 0.5,
                                              angle: 90,
                                            )
                                          ],
                                        )
                                      ],
                                    );
                                  } else {
                                    // return Container(
                                    //   child: Text('data'),
                                    // );
                                    return SfRadialGauge(
                                      enableLoadingAnimation: true,
                                      animationDuration: 4500,
                                      axes: <RadialAxis>[
                                        RadialAxis(
                                          minimum: 0,
                                          maximum: 60,
                                          //  axisLineStyle:AxisLineStyle(color: Colors.white) ,
                                          axisLabelStyle: GaugeTextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),

                                          pointers: <GaugePointer>[
                                            NeedlePointer(
                                              //needleColor: Colors.white,
                                              value: 0,
                                              enableAnimation: true,
                                            )
                                          ],
                                          ranges: <GaugeRange>[
                                            GaugeRange(
                                              startValue: 0,
                                              endValue: 60,
                                              color: Colors.green,
                                            ),
                                            GaugeRange(
                                              startValue: 60,
                                              endValue: 140,
                                              color: Colors.yellow,
                                            ),
                                            GaugeRange(
                                              startValue: 140,
                                              endValue: 200,
                                              color: Colors.red,
                                            )
                                          ],
                                          annotations: <GaugeAnnotation>[
                                            GaugeAnnotation(
                                              widget: Text(
                                                '0 K/H',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              positionFactor: 0.5,
                                              angle: 90,
                                            )
                                          ],
                                        )
                                      ],
                                      // backgroundColor:
                                      //     Color.fromARGB(255, 8, 21, 65),
                                    );
                                  }
                                }),
                          )))),
                ]),
              ),
              // Divider(color: Colors.white,
              // height: 50,
              // ),
              Container(
                width: 350,
                decoration: BoxDecoration(color: Colors.white10),
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Seatbelt',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                  InkWell(
                    child: Expanded(
                      child: Container(
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          width: 250,
                          height: 250,
                          child: Expanded(
                            child: Container(
                              child: StreamBuilder(
                                  stream:
                                      refdb.child('seatbelt/status').onValue,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      var value;

                                      //  double f=0.1;

                                      value = snapshot.data?.snapshot.value;

                                      var S = double.parse(value);

                                      if (S == 9.00) {
                                        return Container(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.green,
                                                    width: 3),
                                                color: Color.fromARGB(
                                                    255, 56, 56, 56),
                                                borderRadius:
                                                    BorderRadius.circular(120)),
                                            width: 250,
                                            height: 250,
                                            child: Center(
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Divider(
                                                      height: 5,
                                                    ),
                                                    Center(
                                                        child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 30, right: 20),
                                                      height: 150,
                                                      width: 150,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Image.asset(
                                                        'assets/icons/s.png',
                                                        color: Colors.green,
                                                      ),
                                                    )),
                                                    Divider(height: 20),
                                                  ]),
                                            ));
                                      } else if (S == 0) {
                                        AwesomeNotifications()
                                            .createNotification(
                                                content: NotificationContent(
                                          id: 60,
                                          channelKey: "schedule",
                                          title: "seat belt Alert",
                                          body: "please wear seat belt",
                                          notificationLayout:
                                              NotificationLayout.BigPicture,
                                          wakeUpScreen: true,
                                          locked: true,
                                          displayOnBackground: true,
                                          actionType: ActionType.Default,
                                        ));
                                        return Container(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.red,
                                                    width: 3),
                                                color: Color.fromARGB(
                                                    255, 56, 56, 56),
                                                borderRadius:
                                                    BorderRadius.circular(120)),
                                            width: 250,
                                            height: 250,
                                            child: Center(
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Divider(
                                                      height: 5,
                                                    ),
                                                    Center(
                                                      child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 30,
                                                                  right: 20),
                                                          height: 150,
                                                          width: 150,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Image.asset(
                                                            'assets/icons/s.png',
                                                            color: Colors.red,
                                                          )),
                                                    ),
                                                    Divider(height: 20),
                                                  ]),
                                            ));
                                      }
                                    }

                                    return Container(
                                      padding:
                                          EdgeInsets.only(top: 10, left: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 3),
                                          color:
                                              Color.fromARGB(255, 56, 56, 56),
                                          borderRadius:
                                              BorderRadius.circular(120)),
                                      width: 250,
                                      height: 250,
                                      child: Center(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Divider(
                                                height: 5,
                                              ),
                                              Center(
                                                  child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 30, right: 20),
                                                height: 150,
                                                width: 150,
                                                decoration: BoxDecoration(),
                                                child: Image.asset(
                                                    'assets/icons/s.png',
                                                    color: Colors.black),
                                              )),
                                              Divider(height: 20),
                                            ]),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ]),
              )
            ]),
          ]),
        ),
      ),
    );
  }
}