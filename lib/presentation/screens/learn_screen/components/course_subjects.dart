import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:folldy_student/presentation/app_route.dart';
import 'package:folldy_student/presentation/components/title_text.dart';
import 'package:folldy_student/presentation/theme/theme.dart';
import 'package:get/get.dart';

import '../../../../data/models/lean_screen_response.dart';

class CourseSubjects extends StatelessWidget {
  const CourseSubjects({
    Key? key,
    required this.subjects,
  }) : super(key: key);

  final List<Subject> subjects;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        defaultSpacerLarge,
        const TitleText(text: "Course", padding: false),
        Padding(
            padding: const EdgeInsets.only(left: defaultPadding),
            child: Text("B.Com Semester ${subjects[0].semester}")),
        defaultSpacerSmall,
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding - defaultPaddingTiny),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: subjects
                .map((e) => Container(
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
                          onTap: () =>
                              Get.toNamed(AppRoute.subjectDetailsScreen),
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
                                    Expanded(
                                        child: Text(
                                      e.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )),
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
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
