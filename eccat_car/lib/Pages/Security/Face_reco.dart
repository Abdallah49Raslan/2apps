import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eccat_car/Pages/Security/Captures.dart';
import 'package:eccat_car/core/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../core/text_style.dart';
import 'Detection.dart';

class FaceReco extends StatefulWidget {
  @override
  _FaceRecoState createState() => _FaceRecoState();
}

class _FaceRecoState extends State<FaceReco> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final database = FirebaseDatabase.instance.reference();
  late StreamSubscription outputstream1;
  String? driverName;
  String? urlPic;
  String? age;
  String? welcomeName;
  String? unwelcomeFlag;
  String? finger;

  @override
  void initState() {
    super.initState();
    activateListeners();
  }

  void playSampleSound() async {
    AudioPlayer player = AudioPlayer();
    await player.setAsset('assets/Security.MP3');
    player.play();
  }

  void activateListeners() {
    outputstream1 = database.child('Security').onValue.listen((event) {
      final String? welcomeFlagValue =
          event.snapshot.child('welcomeflag').value as String?;
      unwelcomeFlag = event.snapshot.child('unwelcomeflag').value as String?;
      final String? fingerprint =
          event.snapshot.child('fingerprint').value as String?;

      // Retrieve driver's information if the welcomeFlagValue matches driverName
      _firestore.collection('drivers').get().then((snapshot) {
        snapshot.docs.forEach((doc) {
          final Object? name = doc.get('driverName');
          final Object? driverAge = doc.get('age');
          final Object? profileUrl = doc.get('profilePicture');

          if (fingerprint == name) {
            setState(() {
              driverName = '$name';
              age = '$driverAge';
              urlPic = '$profileUrl';
              welcomeName = '$welcomeFlagValue';
              finger = '$fingerprint';
            });
          }

          if (unwelcomeFlag != null && unwelcomeFlag!.isNotEmpty) {
            SecuritySound();
            AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: 30,
                channelKey: "health",
                title: "Warning",
                body: "Driver is unauthorized",
                bigPicture:
                    "asset://assets/icons/Attention-sign-icon.png", // warning icon
                notificationLayout: NotificationLayout.BigPicture,
                largeIcon: "asset://assets/icons/Attention-sign-icon.png",
                wakeUpScreen: true,
                locked: true,
                displayOnBackground: true,
                actionType: ActionType.Default,
              ),
            );
          }
          if (welcomeFlagValue != null && welcomeFlagValue.isNotEmpty) {
            AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: 30,
                channelKey: "health",
                title: "Welcome",
                body: "$welcomeName",
                notificationLayout: NotificationLayout.BigPicture,
                wakeUpScreen: true,
                locked: true,
                displayOnBackground: true,
                actionType: ActionType.Default,
              ),
            );
          }
        });
      });
    });
  }

  @override
  void dispose() {
    outputstream1.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height;
    final maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: blackBG,
      body: Column(
        children: [
          Container(
            width: maxWidth,
            height: maxHeight - 80,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/icons/Car.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                children: [
                  SizedBox(height: 75),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: maxWidth,
                      height: maxHeight / 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.blue,
                          width: 4,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            if (urlPic != null)
                              Image.network(
                                urlPic!,
                                fit: BoxFit.cover,
                              ),
                            if (urlPic == null)
                              Icon(
                                Icons.warning,
                                size: 60,
                                color: redColor,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white, // Border color
                      ),
                      color: Colors.black, // Background color of the border
                      borderRadius: BorderRadius.circular(10), // Border radius
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Text(
                          'The Latest Driver is: $driverName\nAge: $age',
                          style: Security,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Detection()),
                        );
                      },
                      child: Text(
                        'Detection',
                        style: headline2,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // Set background color to red
                      ),
                    ),
                  ),
                  const Spacer(flex: 6),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Captures()),
                        );

                        database.child('captureflag').update({
                          'capture': '1',
                        });

                        Future.delayed(Duration(seconds: 5), () {
                          database.child('captureflag').update({
                            'capture': '0',
                          });
                        });
                      },
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 40,
                      ),
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void SecuritySound() {
    if (unwelcomeFlag != null && unwelcomeFlag!.isNotEmpty) {
      playSampleSound();
    }
  }
}
