import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/screens/slide_screen/slide_screen_controller.dart';
import 'package:get/get.dart';

class SlideScreenAppbar extends StatelessWidget {
  const SlideScreenAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SlideScreenController slideScreenController = Get.find();
    return AnimatedBuilder(
      animation: slideScreenController,
      builder: (BuildContext context, Widget? child) {
        return SafeArea(
          child: !slideScreenController.fullScreen
              ? Container()
              : const SizedBox(
                  height: kToolbarHeight,
                  child: Placeholder(),
                ),
        );
      },
    );
  }
}
