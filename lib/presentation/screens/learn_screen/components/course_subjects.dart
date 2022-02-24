import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/components/title_text.dart';
import 'package:folldy_student/presentation/theme/theme.dart';

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
                      width: width * .8,
                      child: AspectRatio(
                          aspectRatio: 2,
                          child: Material(
                              color: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: defaultShadow,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      defaultPaddingSmall),
                                ),
                                padding: const EdgeInsets.all(defaultPadding),
                                child: Column(
                                  children: [
                                    const Text("Banking and Insurance"),
                                    const Spacer(),
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
                              ))),
                    )),
          ),
        ),
      ],
    );
  }
}
