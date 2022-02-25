import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/screens/slide_screen/components/slide_controlls.dart';
import 'package:folldy_student/presentation/screens/slide_screen/slide_screen_controller.dart';
import 'package:folldy_student/presentation/theme/theme.dart';
import 'package:get/get.dart';

import 'minimized_controlls.dart';

class SlideScreenBottomControlls extends StatelessWidget {
  const SlideScreenBottomControlls({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SlideScreenController slideScreenController = Get.find();
    return AnimatedBuilder(
      animation: slideScreenController,
      builder: (BuildContext context, Widget? child) {
        return SizedBox(
            height: kToolbarHeight * 2,
            child: Stack(
              fit: StackFit.expand,
              children: [
                AnimatedPositioned(
                    left: 0,
                    right: 0,
                    bottom: slideScreenController.fullScreen &&
                            slideScreenController.playerOpen
                        ? 0
                        : -kToolbarHeight * 2,
                    duration: defaultAnimationDuration,
                    child: const SlideControlls()),
                AnimatedPositioned(
                    duration: defaultAnimationDuration,
                    left: 0,
                    right: 0,
                    bottom: !slideScreenController.fullScreen &&
                            slideScreenController.playerOpen
                        ? 0
                        : -kToolbarHeight * 2,
                    child: const MinimizedControlls()),
              ],
            ));
      },
    );
  }
}
