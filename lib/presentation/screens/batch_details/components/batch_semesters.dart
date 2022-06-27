

import 'package:flutter/material.dart';

import '../batch_details_controller.dart';
import 'batch_semester.dart';

class BatchSemesters extends StatelessWidget {
  const BatchSemesters({
    Key? key,
    required this.batchDetailsController,
  }) : super(key: key);
  final BatchDetailsController batchDetailsController;

  @override
  Widget build(BuildContext context) {
    List semesters = batchDetailsController.batchDetails!["data"]["semesters"];
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        // padding: const EdgeInsets.symmetric(horizontal: defaultPaddingSmall),
        child: Row(
          children: semesters
              .map((semester) => BatchSemester(
                  // semester: semester,
                  batchDetailsController: batchDetailsController))
              .toList(),
        ));
  }
}