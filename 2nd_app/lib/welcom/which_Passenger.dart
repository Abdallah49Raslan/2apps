import 'package:application_1/passenger1.dart';
import 'package:application_1/passenger2.dart';
import 'package:application_1/welcom/passenger1_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class which_passenger extends StatelessWidget {
  const which_passenger({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Who Are You",
          style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 19,
              width: MediaQuery.of(context).size.width / 2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 13),
              child: Text(
                "You Can Choose \n Who Are You",
                style: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue[400]),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(passenger1_login());
              },
              // ignore: sort_child_properties_last
              child: Text(
                "Passenger1",
                style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 23.w)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60))),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.lightBlue[400])),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 29,
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(passenger1_login());
              },
              // ignore: sort_child_properties_last
              child: Text(
                "Passenger2",
                style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 23.w)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60))),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.lightBlue[400])),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 29,
            ),
          ],
        ),
      ),
    );
  }

  signup() {}
}
