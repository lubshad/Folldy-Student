import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/screens/slide_screen/slide_screen_controller.dart';
import 'package:folldy_student/presentation/theme/theme.dart';
import 'package:get/get.dart';

import 'components/slide_screen_app_bar.dart';
import 'components/slide_screen_bottom_controlls.dart';

class SlideScreen extends StatelessWidget {
  const SlideScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SlideScreenController());
    SlideScreenController slideScreenController = Get.find();
    final height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: slideScreenController.onWillPop,
      child: AnimatedBuilder(
          animation: slideScreenController,
          builder: (context, child) {
            double playerHeight = !slideScreenController.playerOpen
                ? 0
                : slideScreenController.fullScreen
                    ? height
                    : kToolbarHeight * 2;
            return AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                duration: defaultAnimationDuration,
                height: playerHeight,
                child: Stack(fit: StackFit.expand, children: [
                  const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SlideScreenAppbar(),
                  ),
                  Image.asset(
                    "assets/slides/s1.png",
                    fit: BoxFit.cover,
                  ),
                  const Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: SlideScreenBottomControlls()),
                ]));
          }),
    );
  }
}
