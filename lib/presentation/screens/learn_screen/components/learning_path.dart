import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/app_route.dart';
import 'package:get/get.dart';

import '../../../components/title_text.dart';
import '../../../theme/theme.dart';

class LearningPath extends StatelessWidget {
  const LearningPath({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(
          text: "Set what to study now",
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding - defaultPaddingTiny),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
                5,
                (index) => Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: defaultPaddingTiny),
                      width: width * .3,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Colors.blueGrey.withOpacity(.5),
                          ),
                          borderRadius: BorderRadius.circular(defaultPadding)),
                      child: GestureDetector(
                        onTap: () => Get.toNamed(AppRoute.setWhatToStudy),
                        child: AspectRatio(
                            aspectRatio: slideAspectRatio,
                            child: Padding(
                              padding: const EdgeInsets.all(defaultPaddingTiny),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    defaultPadding - defaultPaddingTiny),
                                child: Image.asset(
                                  "assets/slides/s1.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                      ),
                    )),
          ),
        )
      ],
    );
  }
}
