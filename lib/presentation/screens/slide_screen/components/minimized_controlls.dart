import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/screens/slide_screen/slide_screen_controller.dart';
import 'package:get/get.dart';

import '../../../theme/theme.dart';

class MinimizedControlls extends StatelessWidget {
  const MinimizedControlls({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SlideScreenController slideScreenController = Get.find();
    return Stack(fit: StackFit.expand, children: [
      GestureDetector(
        onTap: slideScreenController.openPlayer,
        child: Material(
          color: offWhite,
          child: Container(
            padding: const EdgeInsets.all(defaultPaddingSmall),
            child: Row(
              children: [
                AspectRatio(
                  aspectRatio: slideAspectRatio,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(defaultPaddingTiny),
                      child: Image.asset(
                        "assets/slides/s1.png",
                        fit: BoxFit.cover,
                      )),
                ),
                defaultSpacerHorizontalSmall,
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Text(
                        "Origin and development of the project",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      defaultSpacerTiny,
                      Text(
                        "Module 1",
                        style: Theme.of(context).textTheme.caption,
                      ),
                      defaultSpacerTiny,
                      Text(
                        "Banking And Insurance",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ])),
                defaultSpacerHorizontalSmall,
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: const [
                        CircleAvatar(
                          radius: defaultPadding * 1.4,
                          child: Icon(Icons.play_arrow),
                        ),
                        defaultSpacerHorizontalTiny,
                        CircleAvatar(
                          radius: defaultPadding * 1.4,
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Slider(value: .5, onChanged: (onChanged) {})),
      Positioned(
          top: 0,
          right: 0,
          child: IconButton(
              onPressed: slideScreenController.closePlayer,
              icon: const Icon(Icons.close))),
    ]);
  }
}
