import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get.dart';

class ReadExamples extends StatefulWidget {
  const ReadExamples({super.key});

  @override
  State<ReadExamples> createState() => _ReadExamplesState();
}

class _ReadExamplesState extends State<ReadExamples> {
  String _displayText = 'Results go here';
  String displayprice = 'good';

  final database = FirebaseDatabase.instance.reference();
  String or = "";
  late StreamSubscription ddrf;
  late StreamSubscription mohamed;

  void initState() {
    super.initState();
    activateListeners();
  }

  void activateListeners() {
    ddrf = database.child('dailyspecial').onValue.listen((event) {
      // final double? temp = event.snapshot.child('temp').value as double?;
      final Object? heartRate = event.snapshot.child('desception').value;
      if (event.snapshot.child('desception').value == 'vanalia') {
          // AwesomeNotifications().createNotification(
          //             content: NotificationContent(
          //                 id: 11,
          //                 channelKey: 'schedule',
          //                 title: 'schedule title',
          //                 body: 'schedule body notification',
          //                 bigPicture: "asset://assets/noty.png",
          //                 notificationLayout: NotificationLayout.BigPicture,
          //                 payload: {'asset://raw/bump.mp3': '1234567890'},
          //                 largeIcon: 'asset://assets/images/2.jpeg',
          //                 //  backgroundColor: Colors.amber,
          //                 color: Colors.red),
          //             // schedule: NotificationCalendar.fromDate(date: DateTime.now().add(Duration(seconds: 2)))
          //           );

        Get.snackbar(
          "title",
          "bump",
          duration: Duration(seconds: 1),
        );
        print("object");
      }

      setState(() {
        // displaytemp = temp!;
        or = '$heartRate';
      });
    });
    mohamed = database.child('bump').onValue.listen((event) {
      // final Object? zzz = event.snapshot.child('action1').value;
      final data= Map<String ,dynamic>.from(event.snapshot.value as Map);
      final zzz=data['action1'] as String;

      // if (event.snapshot.child('action1').value == '222' as Map) {
      // // if (event.snapshot.child('action2').value == 222 as dynamic) {
      //   Get.snackbar(
      //     "title",
      //     "zzzzzzzzz",
      //     duration: Duration(seconds: 5),
      //   );
      //   print("object");
      // }
      setState(() {
        displayprice = '$zzz';
      });
    });
  }

  void deactivate() {
    mohamed.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Read_Examples"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                '${or}',
                style: TextStyle(color: Colors.red),
              ),
              Text(
                '$displayprice',
                style: TextStyle(color: Colors.green),
              ),

              // StreamBuilder(
              //     stream: _database
              //         .child('bump')
              //         .orderByKey()
              //         .limitToLast(10)
              //         .onValue,
              //     builder: (context, Snapshot) {
              //       // Map Lane = _database.child("action1").onValue as Map;
              //       final titlelist = <ListTile>[];
              //       if (Snapshot.hasData) {
              //         final myorder = Map<String, dynamic>.from(
              //               (Snapshot.data! as Event).snapshot.value);
              //             // (Snapshot.data! as Event).snapshot.value);
              //         myorder.forEach((key, value) {
              //           final nextorder = Map<String, dynamic>.from(value);
              //           final ordetile = ListTile(
              //             title: Text(nextorder['action1']),
              //           );
              //         });
              //       }

              //       return ListView(children: titlelist,);
              //     })
            ],
          ),
        ),
      ),
    );
  }
}
