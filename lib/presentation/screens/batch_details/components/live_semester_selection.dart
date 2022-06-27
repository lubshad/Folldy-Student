import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/screens/batch_details/batch_details_controller.dart';

import '../../../../utils/constants.dart';
import '../../dashboard_screen/components/dashboard_subject_item.dart';

class LiveSemesterSelection extends StatelessWidget {
  const LiveSemesterSelection({Key? key, required this.batchDetailsController})
      : super(key: key);

  final BatchDetailsController batchDetailsController;

  @override
  Widget build(BuildContext context) {
    List semesters = batchDetailsController.batchDetails!["data"]["semesters"];
    int liveSemester = semesters
        .singleWhere((semester) => semester["live"] == true)["semester"];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultPaddingSmall),
      padding: const EdgeInsets.all(defaultPaddingSmall),
      decoration: BoxDecoration(
          color: zircon,
          borderRadius: BorderRadius.circular(defaultPaddingSmall)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Live",
            // style: Theme.of(context).textTheme.headline6,
          ),
          defaultSpacerHorizontal,
          ColorContainer(
            color: randomColors[0],
            child: Text(
              "Semester $liveSemester",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          if (batchDetailsController.isAdmin)
            PopupMenuButton(
                onSelected: (semester) =>
                    batchDetailsController.makeSemesterLive(semester),
                position: PopupMenuPosition.under,
                icon: const Icon(CupertinoIcons.arrowtriangle_down_circle),
                itemBuilder: (context) => semesters
                    .map((semester) => PopupMenuItem(
                        value: semester,
                        child: Text("Semester ${semester["semester"]}")))
                    .toList()),
        ],
      ),
    );
  }
}
