import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../core/colors.dart';
import 'package:eccat_car/Pages/Iot/BatteryGrid.dart';
import 'package:eccat_car/Pages/Iot/SpeedGrid.dart';
import 'package:eccat_car/Pages/Iot/SeatbeltGrid.dart';

class IoTPage extends StatefulWidget {
  const IoTPage({Key? key}) : super(key: key);

  @override
  State<IoTPage> createState() => _IoTPageState();
}

class _IoTPageState extends State<IoTPage> {
  late DatabaseReference refdb;
  dynamic display;
  dynamic break_display;
  dynamic light_display;
  dynamic batt_display;

  @override
  void initState() {
    refdb = FirebaseDatabase.instance.reference();
    sebelisteners();
    super.initState();
  }

  sebelisteners() {
    // Implement your seatbelt listeners here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "IoT",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: whiteText,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/icons/Car.png"),
          ),
          color: Colors.black,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BatteryGrid(),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  SpeedGrid(),
                  SeatbeltGrid(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
