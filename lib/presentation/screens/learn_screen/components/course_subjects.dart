import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:folldy_student/presentation/app_route.dart';
import 'package:folldy_student/presentation/components/title_text.dart';
import 'package:folldy_student/presentation/theme/theme.dart';
import 'package:get/get.dart';

class CourseSubjects extends StatelessWidget {
  const CourseSubjects({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        defaultSpacerLarge,
        const TitleText(text: "Course", padding: false),
        const Padding(
            padding: EdgeInsets.only(left: defaultPadding),
            child: Text("B.Com Second Semester")),
        defaultSpacerSmall,
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding - defaultPaddingTiny),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
                5,
                (index) => Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: defaultPaddingTiny,
                          vertical: defaultPaddingSmall),
                      decoration: BoxDecoration(
                        boxShadow: defaultShadow,
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(defaultPaddingSmall),
                      ),
                      width: width * .8,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius:
                              BorderRadius.circular(defaultPaddingSmall),
                          onTap: () => Get.toNamed(AppRoute.subjectDetailsScreen),
                          child: Container(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svgs/subject_icon.svg",
                                    ),
                                    defaultSpacerHorizontalTiny,
                                    const Text("Banking and Insurance"),
                                  ],
                                ),
                                defaultSpacerSmall,
                                Row(
                                  children: List.generate(
                                      4,
                                      (index) => Expanded(
                                            child: AspectRatio(
                                              aspectRatio: 1,
                                              child: Container(
                                                margin: const EdgeInsets.all(
                                                    defaultPaddingTiny * .5),
                                                decoration: const BoxDecoration(
                                                    color: Colors.blue,
                                                    shape: BoxShape.circle),
                                              ),
                                            ),
                                          )),
                                ),
                                defaultSpacerSmall,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text("Topics"),
                                    Text("Published"),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
          ),
        ),
      ],
    );
  }
}
