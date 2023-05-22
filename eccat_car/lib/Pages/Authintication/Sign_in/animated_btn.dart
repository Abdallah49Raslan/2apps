import 'package:eccat_car/core/colors.dart';
import 'package:flutter/cupertino.dart';

import 'package:rive/rive.dart';

import '../../../core/text_style.dart';

class AnimatedBtn extends StatelessWidget {
  const AnimatedBtn({
    Key? key,
    required RiveAnimationController btnAnimationColtroller,
    required this.press,
  })  : _btnAnimationController = btnAnimationColtroller,
        super(key: key);

  final RiveAnimationController _btnAnimationController;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 480) {
    }
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        height: screenWidth > 480 ? 150 : 64,
        width: screenWidth > 480 ? 300 : 260,
        child: Stack(
          children: [
            RiveAnimation.asset(
              "assets/RiveAssets/button.riv",
              controllers: [_btnAnimationController],
            ),
            Positioned.fill(
              // But it's not center
              top: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.arrow_right),
                  SizedBox(width: 8),
                  Text("Start The Car App",
                      style: headline2.copyWith(color: primaryColor)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
