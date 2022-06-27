import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/screens/batch_details/batch_details_controller.dart';
import 'package:folldy_student/presentation/screens/dashboard_screen/components/dashboard_subject_item.dart';
import 'package:folldy_student/utils/constants.dart';

class BatchSemester extends StatelessWidget {
  const BatchSemester({
    Key? key,
    // required this.semester,
    required this.batchDetailsController,
  }) : super(key: key);

  // final Map<String, dynamic> semester;
  final BatchDetailsController batchDetailsController;

  @override
  Widget build(BuildContext context) {
    // List subjects = semester["subjects"];
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     TitleWithAction(
    //       onPressed: semester["live"]
    //           ? () {}
    //           : () => batchDetailsController.makeSemesterLive(semester),
    //       title: "Semester ${semester["semester"]}",
    //       actionText: semester["live"] ? "Live" : "Make Live",
    //     ),
    //     SingleChildScrollView(
    //       padding: const EdgeInsets.symmetric(
    //           horizontal: defaultPadding - defaultPaddingTiny,
    //           vertical: defaultPaddingSmall),
    //       scrollDirection: Axis.horizontal,
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: subjects
    //             .map((subject) => SemesterSubject(
    //                   subject: subject,
    //                   batchDetailsController: batchDetailsController,
    //                 ))
    //             .toList(),
    //       ),
    //     )
    //   ],
    // );
    List semesters = batchDetailsController.batchDetails!["data"]["semesters"];
    Map<String, dynamic> liveSemester =
        semesters.singleWhere((element) => element["live"]);
    List subjects = liveSemester["subjects"];
    return Container(
      width: MediaQuery.of(context).size.width - (defaultPadding),
      decoration: BoxDecoration(
        color: zircon,
        borderRadius: BorderRadius.circular(defaultPaddingSmall),
      ),
      padding: const EdgeInsets.all(defaultPadding),
      margin: const EdgeInsets.symmetric(horizontal: defaultPaddingSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Semester ${liveSemester["semester"]}",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          defaultSpacerSmall,
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: defaultPaddingSmall,
            runSpacing: defaultPaddingSmall,
            children: [
              ...subjects
                  .where((element) => element["selected"])
                  .map(
                    (subject) => ColorContainer(
                      borderRadius: defaultPaddingLarge,
                      child: Padding(
                        padding: const EdgeInsets.all(defaultPaddingSmall),
                        child: Text(
                          subject["name"],
                        ),
                      ),
                    ),
                  )
                  .toList(),
              PopupMenuButton(
                onSelected: (subject) =>
                    batchDetailsController.addSubjectToDashboard(subject),
                itemBuilder: (BuildContext context) => subjects
                    .map((subject) => PopupMenuItem(
                        value: subject, child: Text(subject["name"])))
                    .toList(),
                child: ColorContainer(
                  color: contessa,
                  borderRadius: defaultPaddingLarge,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultPaddingSmall,
                          horizontal: defaultPadding),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            CupertinoIcons.add,
                            size: defaultPadding,
                            color: Colors.white,
                          ),
                          Text("Add Subject",
                              style: TextStyle(color: Colors.white)),
                        ],
                      )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
