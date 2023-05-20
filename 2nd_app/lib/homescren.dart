// ignore_for_file: camel_case_types

import 'package:application_1/Abdallah/Authintication/login_page.dart';
import 'package:application_1/functions/alertexitapp.dart';
import 'package:application_1/healthcare/driver_ui.dart';
import 'package:application_1/login/animatedlogin.dart';
import 'package:application_1/page/car_page.dart';
import 'package:application_1/page/home_Page.dart';
import 'package:application_1/page/person_page.dart';
import 'package:application_1/page/search_page.dart';
import 'package:application_1/page/settings_page.dart';
import 'package:application_1/side_menu/drawer.dart';
import 'package:application_1/welcom/welcom.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'Abdallah/Security/Face_reco.dart';
import 'Iot/final_design.dart';


class homescren extends StatefulWidget {
  // const homescren({super.key});
  final int initialIndex; // add initialIndex parameter

  const homescren({Key? key, required this.initialIndex}) : super(key: key);

  @override
  State<homescren> createState() => _homescrenState();
}

class _homescrenState extends State<homescren> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  final screens = [
    HealthCareDriver(),
    Car_page(),
    IoTPage(),
    FaceReco(),
    WebViewApp(),
    SearchPage(),
  ];

  final items = <Widget>[
    Icon(
      CupertinoIcons.heart_slash_circle_fill,
      size: 30.h,
    ),
    Icon(
      CupertinoIcons.car_detailed,
      size: 30.h,
    ),
    Icon(
      CupertinoIcons.battery_75_percent,
      size: 30.h,
    ),
    Icon(
      CupertinoIcons.video_camera,
      size: 30.h,
    ),
    Icon(
      Icons.web,
      size: 30.h,
    ),
    Icon(
      Icons.app_blocking,
      size: 30.h,
    ),
  ];
  // int index = 1;
  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.initialIndex; // set initial value here
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        // SystemUiOverlayStyle.light,
        SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light));
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: ClipRect(
          child: Scaffold(
            extendBody: true,
            // backgroundColor: Colors.yellow,
            // appBar: AppBar(
            backgroundColor: Colors.black,
            //   bottomOpacity: 5.1,
            //   // foregroundColor: Colors.red,
            //   // title: Text(
            //   //   '',
            //   //   style: TextStyle(fontSize: 30.sp),
            //   // ),
            //   centerTitle: true,
            // ),
            // drawer: Drawer(
            //   child: Menu(),
            // ),
            // drawerScrimColor: Colors.amber,
            // Image.asset(
            //   'assets/11111.jfif',
            //   height: double.infinity,
            //   width: double.infinity,
            //   fit: BoxFit.cover,
            // ),
            //     Column(
            //   children: [
            //     Center(
            //       child: Text(
            //         '$index',
            //         style: TextStyle(color: Colors.red, fontSize: 100),
            //       ),
            //     ),
            //     ElevatedButton(
            //         onPressed: () {
            //           final navigationState = navigationKey.currentState!;
            //           navigationState.setPage(0);
            //         },
            //         child: Text('go to'))
            //   ],
            // ),
            body: screens[index],
            bottomNavigationBar: Theme(
                data: Theme.of(context)
                    .copyWith(iconTheme: IconThemeData(color: Colors.white)),
                child: WillPopScope(
                  onWillPop: alertExitApp,
                  child: CurvedNavigationBar(
                    key: navigationKey,
                    color: Colors.black,
                    buttonBackgroundColor: Colors.blue,
                    backgroundColor: Colors.transparent,
                    height: 60,
                    animationCurve: Curves.easeInOut,
                    animationDuration: Duration(milliseconds: 600),
                    items: items,
                    index: index,
                    onTap: (index) {
                      setState(() {
                        this.index = index;
                      });
                    },
                  ),
                )),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  Get.offAll(LoginPage());
                });
              },
              tooltip: 'Increment',
              child: const Icon(CupertinoIcons.home),
            ),
          ),
        ),
      ),
    );
  }
}
