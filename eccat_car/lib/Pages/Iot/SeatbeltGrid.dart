import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../core/colors.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:eccat_car/Pages/Iot/final_design.dart';

Widget SeatbeltGrid() {
  var refdb = FirebaseDatabase.instance.ref();
  dynamic display;
  dynamic break_display;
  dynamic light_display;
  dynamic batt_display;
  return Container(
    width: 350,
    decoration: BoxDecoration(color: Colors.white10),
    child: Column(children: [
      Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Text(
          'Seatbelt',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
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
                      stream: refdb.child('seatbelt/status').onValue,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var value;

                          //  double f=0.1;

                          value = snapshot.data?.snapshot.value;

                          var S = double.parse(value);

                          if (S == 9.00) {
                            return Container(
                              padding: EdgeInsets.only(top: 10, left: 10),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.green, width: 3),
                                  color: Color.fromARGB(255, 56, 56, 56),
                                  borderRadius: BorderRadius.circular(120)),
                              width: 250,
                              height: 250,
                              child: Center(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                      Divider(height: 20),
                                    ]),
                              ),
                            );
                          } else if (S == 0) {
                            AwesomeNotifications().createNotification(
                                content: NotificationContent(
                              id: 60,
                              channelKey: "schedule",
                              title: "seat belt Alert",
                              body: "please wear seat belt",
                              notificationLayout: NotificationLayout.BigPicture,
                              wakeUpScreen: true,
                              locked: true,
                              displayOnBackground: true,
                              actionType: ActionType.Default,
                            ));
                            return Container(
                              padding: EdgeInsets.only(top: 10, left: 10),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.red, width: 3),
                                  color: Color.fromARGB(255, 56, 56, 56),
                                  borderRadius: BorderRadius.circular(120)),
                              width: 250,
                              height: 250,
                              child: Center(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      Divider(height: 20),
                                    ]),
                              ),
                            );
                          }
                        }

                        return Container(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 3),
                              color: Color.fromARGB(255, 56, 56, 56),
                              borderRadius: BorderRadius.circular(120)),
                          width: 250,
                          height: 250,
                          child: Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Divider(
                                    height: 5,
                                  ),
                                  Center(
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(top: 30, right: 20),
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(),
                                      child: Image.asset('assets/icons/s.png',
                                          color: Colors.black),
                                    ),
                                  ),
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
  );
}
