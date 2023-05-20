import 'dart:math';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';
import '../../../core/colors.dart';
import '../../../core/rive_utils.dart';
import '../../../functions/alertexitapp.dart';
import '../../../healthcare/passenger1_ui.dart';
import '../../../page/person_page.dart';
import '../../Authintication/User_Profile.dart';
import '../../Authintication/login_page.dart';
import '../../Security/user_check.dart';
import 'Custom_start.dart';

// We are done with our 5th and last episode
// Thank you so much for watching entire serise
// Bye

class EntryCustomer extends StatefulWidget {
  final int initialIndex;

  const EntryCustomer({Key? key, required this.initialIndex}) : super(key: key);

  @override
  State<EntryCustomer> createState() => _EntryCustomerState();
}

class _EntryCustomerState extends State<EntryCustomer>
    with SingleTickerProviderStateMixin {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;

  // Let's chnage the name
  late SMIBool isSideBarClosed;

  bool isSideMenuClosed = true;
  int currentpages = 0;
  final screens = [
    const passenger1_ui(),
    UserCheck(),
    const CustomerStartPage(),
    const WebViewApp(),
    const UserInfoPage()
  ];

  final items = <Widget>[
    Icon(
      CupertinoIcons.heart_slash_circle_fill,
      size: 30.h,
    ),
    Icon(
      Icons.safety_check,
      size: 30.h,
    ),
    Icon(
      Icons.home,
      size: 30.h,
    ),
    Icon(
      Icons.web,
      size: 30.h,
    ),
    Icon(
      Icons.person,
      size: 30.h,
    ),
  ];

  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.initialIndex;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });

    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn),
    );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = 288.0;

    if (screenWidth > 480) {
      containerWidth = screenWidth / 2;
    }
    return Scaffold(
      backgroundColor: backgroundColor2,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          screens[index],
          Positioned(
            top: 30.0,
            right: 16.0,
            child: GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.logout,
                  color: backgroundColor2,
                  size: 30.0,
                ),
              ),
            ),
          ),
        ],
      ),
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
        ),
      ),
    );
  }
}
