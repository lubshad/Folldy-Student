import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/screens/batch_details/batch_details_controller.dart';
import 'package:folldy_student/presentation/screens/batch_details/components/batch_semester.dart';

import '../../../../utils/constants.dart';
import 'batch_students.dart';
import 'batch_teachers.dart';
import 'live_semester_selection.dart';

class BatchDetailsBody extends StatelessWidget {
  const BatchDetailsBody({Key? key, required this.batchDetailsController})
      : super(key: key);

  final BatchDetailsController batchDetailsController;

  @override
  Widget build(BuildContext context) {
    // return ListView.separated(
    //   itemCount:
    //       batchDetailsController.batchDetails!["data"]["semesters"]?.length ??
    //           0,
    //   itemBuilder: (context, index) => Builder(builder: (context) {
    //     final semester =
    //         batchDetailsController.batchDetails!["data"]["semesters"][index];
    //     return BatchSemester(
    //       semester: semester,
    //       batchDetailsController: batchDetailsController,
    //     );
    //   }),
    //   separatorBuilder: (BuildContext context, int index) => const Divider(
    //     height: defaultPaddingLarge,
    //   ),
    // );
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: defaultPaddingSmall),
      child: Column(
        children: [
          LiveSemesterSelection(
            batchDetailsController: batchDetailsController,
          ),
          defaultSpacerSmall,
          // BatchSemesters(batchDetailsController: batchDetailsController),
          BatchSemester(
              // semester: semester,
              batchDetailsController: batchDetailsController),
          defaultSpacerSmall,
          BatchTeachers(batchDetailsController: batchDetailsController),
          defaultSpacerSmall,
          const BatchStudents(),
        ],
      ),
    );
  }
}
