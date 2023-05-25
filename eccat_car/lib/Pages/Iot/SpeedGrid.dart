import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

Widget SpeedGrid() {
  var refdb = FirebaseDatabase.instance.ref();
  return Container(
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
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      InkWell(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          width: 400,
          height: 300,
          child: Container(
            child: StreamBuilder(
                stream: refdb.child('speed/sp').onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var num;

                    num = snapshot.data?.snapshot.value;

                    var c = double.parse(num);

                    if (c >= 35) {
                      AwesomeNotifications().createNotification(
                          content: NotificationContent(
                        id: 51,
                        channelKey: "schedule",
                        title: "speed Alert",
                        body: "speed is very high",
                        notificationLayout: NotificationLayout.BigPicture,
                        wakeUpScreen: true,
                        locked: true,
                        displayOnBackground: true,
                        actionType: ActionType.Default,
                      ));
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
                                      fontWeight: FontWeight.bold),
                                ),
                                positionFactor: 0.5,
                                angle: 90,
                              ),
                            ],
                          ),
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
                              value: c,
                              enableAnimation: true,
                            ),
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
                                    fontWeight: FontWeight.bold),
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
                            ),
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
                                    fontWeight: FontWeight.bold),
                              ),
                              positionFactor: 0.5,
                              angle: 90,
                            ),
                          ],
                        ),
                      ],
                      // backgroundColor:
                      //     Color.fromARGB(255, 8, 21, 65),
                    );
                  }
                }),
          ),
        ),
      ),
    ]),
  );
}
