// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:application_1/AI/ai.dart';
import 'package:application_1/AI/read.dart';
import 'package:application_1/notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool selected0 = false;
  bool selected1 = false;
  bool selected2 = false;
  bool selected3 = false;
  bool selected4 = false;
  bool selected5 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288.w,
        height: double.infinity,
        color: Color(0xFF17203A),
        // color: selected ? Color(0xFF6792FF) : Color(0xFF17203A),
        child: SafeArea(
            child: Column(
          children: [
            ListTile(
              onTap: () {
                setState(() {
                  selected0 = !selected0;
                });
              },
              selected: true,
              selectedColor: selected0 ? Color(0xFF6792FF) : Color(0xFF17203A),
              leading: CircleAvatar(
                backgroundColor: Colors.white24,
                child: Icon(
                  CupertinoIcons.person,
                  color: Colors.white,
                ),
              ),
              title: Text(
                "Osama Said",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                "Senior",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 30, 0, 0),
              alignment: Alignment(-1, 0),
              child: Text(
                "Browse",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            Divider(
              thickness: 10,
            ),
            Stack(
              children: [
                Container(
                  child: Positioned(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected1 = !selected1;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 333),
                        curve: Curves.bounceIn,
                        decoration: BoxDecoration(
                            color: selected1
                                ? Color(0xFF6792FF)
                                : Color(0xFF17203A),
                            // color: Color(0xFF6792FF),
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          selectedColor: Color(0xFF6792FF),
                          selected: true,
                          leading: CircleAvatar(
                            backgroundColor: Colors.white24,
                            child: Icon(
                              CupertinoIcons.home,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            "Home",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Container(
              child: Positioned(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selected2 = !selected2;
                      Get.to(Fetch_Data());
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 333),
                    curve: Curves.bounceIn,
                    decoration: BoxDecoration(
                        color:
                            selected2 ? Color(0xFF6792FF) : Color(0xFF17203A),
                        // color: Color(0xFF6792FF),
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      selectedColor: Color(0xFF6792FF),
                      selected: true,
                      leading: CircleAvatar(
                        backgroundColor: Colors.white24,
                        child: Icon(
                          CupertinoIcons.search,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        "Search",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Divider(),
            Container(
              child: Positioned(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selected3 = !selected3;
                      Get.to(ReadExamples());
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 333),
                    curve: Curves.bounceIn,
                    decoration: BoxDecoration(
                        color:
                            selected3 ? Color(0xFF6792FF) : Color(0xFF17203A),
                        // color: Color(0xFF6792FF),
                        borderRadius: BorderRadius.circular(10)),
                    child: const ListTile(
                      selectedColor: Color(0xFF6792FF),
                      selected: true,
                      leading: CircleAvatar(
                        backgroundColor: Colors.white24,
                        child: Icon(
                          CupertinoIcons.book,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        "Read",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.fromLTRB(10, 30, 0, 0),
              alignment: Alignment(-1, 0),
              child: const Text(
                "History",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            Divider(
              thickness: 10,
            ),
            Container(
              child: Positioned(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selected4 = !selected4;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.bounceIn,
                    decoration: BoxDecoration(
                        color:
                            selected4 ? Color(0xFF6792FF) : Color(0xFF17203A),
                        // color: Color(0xFF6792FF),
                        borderRadius: BorderRadius.circular(10)),
                    child: const ListTile(
                      selectedColor: Color(0xFF6792FF),
                      selected: true,
                      leading: CircleAvatar(
                        backgroundColor: Colors.white24,
                        child: Icon(
                          CupertinoIcons.clock,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        "History",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Divider(),
            Container(
              child: Positioned(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selected5 = !selected5;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 333),
                    curve: Curves.bounceIn,
                    decoration: BoxDecoration(
                        color:
                            selected5 ? Color(0xFF6792FF) : Color(0xFF17203A),
                        // color: Color(0xFF6792FF),
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      selectedColor: Color(0xFF6792FF),
                      selected: true,
                      leading: CircleAvatar(
                        backgroundColor: Colors.white24,
                        child: Icon(
                          CupertinoIcons.antenna_radiowaves_left_right,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        "Notifications",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Divider(),
            ElevatedButton.icon(
              onPressed: () {
                Get.to(Notifications());
              },
              icon: Icon(Icons.holiday_village),
              label: Text(
                "Noteification",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        )),
      ),
    );
  }
}
