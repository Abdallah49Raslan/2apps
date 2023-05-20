import 'package:application_1/login/animatedlogin.dart';
import 'package:application_1/passenger1.dart';
import 'package:application_1/welcom/which_Passenger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class welcom extends StatelessWidget {
  const welcom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Welcom",
      //     style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      // ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 9,
            width: MediaQuery.of(context).size.width / 2,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 13),
            child: Text(
              "You Are Welcom In Autonomous \n Car System \n Are You ....?",
              style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue[400]),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(36, 0, 32, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(login_screen());
                    },
                    // ignore: sort_child_properties_last
                    child: Text(
                      "Driver",
                      style: TextStyle(
                          fontSize: 40.sp, fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            vertical: 15.h, horizontal: 23.w)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.lightBlue[400])),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 29,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(which_passenger());
                  },
                  // ignore: sort_child_properties_last
                  child: Text(
                    "Passenger",
                    style:
                        TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 23.w)),
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
                    // Get.to(ok());
                  },
                  // ignore: sort_child_properties_last
                  child: Text(
                    "Guest",
                    style:
                        TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 23.w)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60))),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlue[400])),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  signup() {}
}
