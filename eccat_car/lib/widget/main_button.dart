import 'package:flutter/material.dart';

import '../core/text_style.dart';

class Mainbutton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final String? image;
  final Color? txtColor;
  final Color btnColor;

  const Mainbutton({
    Key? key,
    required this.onTap,
    required this.text,
    this.image,
    this.txtColor,
    required this.btnColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final screenWidth = constraints.maxWidth;
        final isLargeScreen = screenWidth > 480;

        final double buttonHeight = isLargeScreen ? 70.0 : 50.0;

        return GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            height: buttonHeight,
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: btnColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (image != null)
                  Image.asset(
                    'assets/image/$image',
                    height: isLargeScreen ? 30.0 : 25.0,
                    width: isLargeScreen ? 70.0 : 60.0,
                  ),
                Text(
                  text,
                  style: isLargeScreen
                      ? headline2.copyWith(fontSize: 30)
                      : headline2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
