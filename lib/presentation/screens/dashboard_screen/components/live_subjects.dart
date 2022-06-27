import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/components/title_with_view_all.dart';
import 'package:folldy_student/presentation/route.dart';
import 'package:folldy_student/utils/constants.dart';

class LiveSubjects extends StatelessWidget {
  const LiveSubjects({
    Key? key,
    required this.subjects,
  }) : super(key: key);

  final List subjects;

  @override
  Widget build(BuildContext context) {
    if (subjects.isEmpty) {
      return Container();
    }
    return Container(
        padding: const EdgeInsets.only(bottom: defaultPadding),
        color: zircon,
        child: Column(
          children: [
            TitleWithAction(title: "Live Subjects", onPressed: () {}),
            ...List.generate(
                subjects.length,
                (index) => LiveSubjectItem(
                    subject: subjects[index],
                    color: randomColors[index])).toList(),
          ],
        ));
  }
}

class LiveSubjectItem extends StatelessWidget {
  const LiveSubjectItem({Key? key, required this.subject, required this.color})
      : super(key: key);
  final Color color;
  final Map<String, dynamic> subject;

  @override
  Widget build(BuildContext context) {
    DateTime startDate = DateTime.parse(subject["batch"]['start']);
    DateTime endDate = DateTime.parse(subject["batch"]['end']);
    subject["color"] = color;
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoute.subjectDetails, arguments: subject),
      child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          margin: const EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultPaddingSmall),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(defaultPaddingLarge),
              boxShadow: defaultShadow),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${subject["batch"]["course"]} ${startDate.year}-${endDate.year.toString().substring(2, 4)}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        "Semester ${subject["semester"]}",
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  PopupMenuButton(
                    itemBuilder: ((context) => []),
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              defaultSpacerSmall,
              Text(
                subject["name"],
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              defaultSpacer,
              Builder(builder: (context) {
                List modules = subject["presentations"]["modules"];
                return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: modules
                        .map((module) => Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: defaultPaddingTiny),
                                  alignment: Alignment.center,
                                  width: defaultPaddingLarge,
                                  height: defaultPaddingLarge,
                                  decoration: const BoxDecoration(
                                    color: frenchGrey,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text((module["module"]).toString()),
                                ),
                                Positioned(
                                  left: defaultPaddingTiny,
                                  right: defaultPaddingTiny,
                                  bottom: defaultPaddingTiny,
                                  top: defaultPaddingTiny,
                                  child: FittedBox(
                                    child: CircularProgressIndicator(
                                      value: module["publishedPresentations"] /
                                          module["totalPresentations"],
                                      color: color,
                                    ),
                                  ),
                                )
                              ],
                            ))
                        .toList());
              })
            ],
          )),
    );
  }
}
