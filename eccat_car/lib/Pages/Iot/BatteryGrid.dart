import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

Widget BatteryGrid() {
  var refdb = FirebaseDatabase.instance.ref();
  return Container(
    width: 350,
    decoration: BoxDecoration(color: Colors.white10),
    child: Column(children: [
      Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Text(
          'Battery',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      InkWell(
        child: Container(
          child: StreamBuilder(
              stream: refdb.child('battery/batt').onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var b;
                  double p = 0.5;
                  b = snapshot.data?.snapshot.value;
                  var B = double.parse(b);
                  if (B <= 25) {
                    p = B / 100;
                    AwesomeNotifications().createNotification(
                      content: NotificationContent(
                        id: 50,
                        channelKey: "schedule",
                        title: "battery Alert",
                        body: "battery is very low",
                        notificationLayout: NotificationLayout.BigPicture,
                        wakeUpScreen: true,
                        locked: true,
                        displayOnBackground: true,
                        actionType: ActionType.Default,
                      ),
                    );
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
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.red,
                    );
                  } else if (B > 25) {
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
                              color: Colors.white)),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.green,
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
              }),
        ),
      ),
    ]),
  );
}
