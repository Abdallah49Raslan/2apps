import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../core/colors.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:eccat_car/Pages/Iot/BatteryGrid.dart';
import 'package:eccat_car/Pages/Iot/SpeedGrid.dart';
import 'package:eccat_car/Pages/Iot/SeatbeltGrid.dart';

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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "Iot",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: whiteText,
          ),
        ),
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
            BatteryGrid(),
            SizedBox(
              height: 20,
            ),
            Column(children: [
              SpeedGrid(),
              // Divider(color: Colors.white,
              // height: 50,
              // ),

              SeatbeltGrid(),
            ]),
          ]),
        ),
      ),
    );
  }
}
