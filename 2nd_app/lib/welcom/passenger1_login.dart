// // // ignore_for_file: prefer_const_constructors

import 'package:application_1/homescren.dart';
import 'package:application_1/login/animation_enum.dart';
import 'package:application_1/passenger1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class passenger1_login extends StatefulWidget {
  const passenger1_login({super.key});

  @override
  State<passenger1_login> createState() => _passenger1_loginState();
}

class _passenger1_loginState extends State<passenger1_login> {
  Artboard? riveArtboard;
  late RiveAnimationController controllerIdle;
  late RiveAnimationController controllerHandsUp;
  late RiveAnimationController controllerHandsDown;
  late RiveAnimationController controllerLookLeft;
  late RiveAnimationController controllerLookRight;
  late RiveAnimationController controllerSuccess;
  late RiveAnimationController controllerFail;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String testEmail = "passenger1@eccat.edu";
  String testPassword = "1234567";
  final passwordFocusNode = FocusNode();

  bool isLookingRight = false;
  bool isLookingLeft = false;

  void removeAllControllers() {
    riveArtboard?.artboard.removeController(controllerIdle);
    riveArtboard?.artboard.removeController(controllerHandsUp);
    riveArtboard?.artboard.removeController(controllerHandsDown);
    riveArtboard?.artboard.removeController(controllerLookLeft);
    riveArtboard?.artboard.removeController(controllerLookRight);
    riveArtboard?.artboard.removeController(controllerSuccess);
    riveArtboard?.artboard.removeController(controllerFail);
    isLookingLeft = false;
    isLookingRight = false;
  }

  void addIdleController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerIdle);
    debugPrint("idleee");
  }

  void addHandsUpController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerHandsUp);
    debugPrint("hands up");
  }

  void addHandsDownController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerHandsDown);
    debugPrint("hands down");
  }

  void addSuccessController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerSuccess);
    debugPrint("Success");
  }

  void addFailController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerFail);
    debugPrint("Faillll");
  }

  void addLookRightController() {
    removeAllControllers();
    isLookingRight = true;
    riveArtboard?.artboard.addController(controllerLookRight);
    debugPrint("Righttt");
  }

  void addLookLeftController() {
    removeAllControllers();
    isLookingLeft = true;
    riveArtboard?.artboard.addController(controllerLookLeft);
    debugPrint("Leftttttt");
  }

  void checkForPasswordFocusNodeToChangeAnimationState() {
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        addHandsUpController();
      } else if (!passwordFocusNode.hasFocus) {
        addHandsDownController();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controllerIdle = SimpleAnimation(AnimationEnum.idle.name);
    controllerHandsUp = SimpleAnimation(AnimationEnum.Hands_up.name);
    controllerHandsDown = SimpleAnimation(AnimationEnum.hands_down.name);
    controllerLookRight = SimpleAnimation(AnimationEnum.Look_down_right.name);
    controllerLookLeft = SimpleAnimation(AnimationEnum.Look_down_left.name);
    controllerSuccess = SimpleAnimation(AnimationEnum.success.name);
    controllerFail = SimpleAnimation(AnimationEnum.fail.name);

    rootBundle.load('assets/loginanimation.riv').then((data) {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      artboard.addController(controllerIdle);
      setState(() {
        riveArtboard = artboard;
      });
    });

    checkForPasswordFocusNodeToChangeAnimationState();
  }

  void validateEmailAndPassword() {
    Future.delayed(const Duration(seconds: 1), () {
      if (formKey.currentState!.validate()) {
        addSuccessController();
      } else {
        addFailController();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            "Passenger_1",
            style: TextStyle(fontSize: 30.sp),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 30),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: riveArtboard == null
                          ? SizedBox.shrink()
                          : Rive(artboard: riveArtboard!),
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          // e-mail
                          TextFormField(
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            // obscureText: true,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.lightBlue[400],
                              ),
                              suffixIcon: Icon(Icons.person),
                              labelText: "e-mail:",
                              labelStyle: TextStyle(fontSize: 30),
                              border: OutlineInputBorder(
                                  gapPadding: 10.0,
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(100, 100))),
                              // icon: Icon(Icons.email)
                              /* border: InputBorder.none*/
                            ),
                            validator: (Value) =>
                                Value != testEmail ? "Wrong email" : null,
                            onChanged: (Value) {
                              if (Value.isNotEmpty &&
                                  Value.length < 12 &&
                                  !isLookingLeft) {
                                addLookLeftController();
                              } else if (Value.isNotEmpty &&
                                  Value.length > 12 &&
                                  !isLookingRight) {
                                addLookRightController();
                              }
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 25,
                          ),

                          //pass
                          TextFormField(
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            obscureText: true,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.lightBlue[400],
                              ),
                              suffixIcon: Icon(Icons.visibility),
                              labelText: "Password:",
                              labelStyle: TextStyle(fontSize: 30),
                              border: OutlineInputBorder(
                                  gapPadding: 10.0,
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(100, 100))),
                              // icon: Icon(Icons.email)
                              /* border: InputBorder.none*/
                            ),
                            focusNode: passwordFocusNode,
                            validator: (value) =>
                                value != testPassword ? "Wrong password" : null,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 18,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              passwordFocusNode.unfocus();

                              validateEmailAndPassword();
                              if (formKey.currentState!.validate()) {
                                Future.delayed(Duration(seconds: 3), () {
                                  // Navigate to the next page if the email and password are correct
                                  Get.to(passenger1(
                                    initialIndex: 0,
                                  ));
                                });
                              } else {
                                // Show an error message if the email or password is incorrect
                                addFailController();
                              }
                            },
                            // ignore: sort_child_properties_last
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 123)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(60))),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.lightBlue[400])),
                          ),
                          // Container(
                          //   child: TextButton(
                          //     onPressed: () {},
                          //     child: Text("login"),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
