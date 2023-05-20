// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';



class Fetch_Data extends StatefulWidget {
  const Fetch_Data({super.key});

  @override
  State<Fetch_Data> createState() => Fetch_DataState();
}

class Fetch_DataState extends State<Fetch_Data> {
  Query dpRef = FirebaseDatabase.instance.ref().child('bump');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('bump');

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   testsnak();
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fetching_Data')),
      body: Stack(
        children: [
         
          FirebaseAnimatedList(
            query: dpRef.limitToFirst(5),
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map Lane = snapshot.value as Map;

              // Lane['key'] = snapshot.key;
              print(snapshot.child('action1').value);
              if (snapshot.child('action1').value == '222') {
                //  AwesomeNotifications().createNotification(
                //       content: NotificationContent(
                //           id: 11,
                //           channelKey: 'schedule',
                //           title: 'schedule title',
                //           body: 'schedule body notification',
                //           bigPicture: "asset://assets/noty.png",
                //           notificationLayout: NotificationLayout.BigPicture,
                //           payload: {'asset://raw/bump.mp3': '1234567890'},
                //           largeIcon: 'asset://assets/images/2.jpeg',
                //           //  backgroundColor: Colors.amber,
                //           color: Colors.red),
                //       // schedule: NotificationCalendar.fromDate(date: DateTime.now().add(Duration(seconds: 2)))
                //     );

            

                print("object");
              }

              return Container();

              // return listItem(Lane: Lane);
            },
          ),
           ElevatedButton(
              onPressed: () {
                reference.child('bump/action1').remove();
              },
              child: Text('delet')),
        ],
      ),
    );
  }

  listItem({required Map Lane}) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            Lane['action1'],
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                reference.child('bump').remove();
              },
              child: Text('delet'))
          // Text(
          //   'Age',
          //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Text(
          //   'Salary',
          //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          // ),
        ],
      ),
    );
  }
}



    // Get.snackbar(
                //   "title",
                //   "bump",
                //   duration: Duration(seconds: 2),
                // );




// showDialog(
              //     context: context,
              //     builder: ((context) {
              //       return AlertDialog(
                      
              //         title: Text("done"),content: Text('will done'),
              //       );
              //     }));