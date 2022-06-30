import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/screens/dashboard_screen/components/recently_created.dart';
import 'package:folldy_student/utils/constants.dart';

import 'dashboard_subject_list.dart';
import 'live_subjects.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({
    Key? key,
    required this.dashboardDetails,
  }) : super(key: key);

  final Map<String, dynamic> dashboardDetails;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DashboardSubjectList(
            subjects: dashboardDetails["subjects"],
          ),
          defaultSpacerSmall,
          RecentlyCreated(presentations: dashboardDetails["recently_viewed"]),
          defaultSpacerSmall,
          LiveSubjects(subjects: dashboardDetails["subjects"])
        ],
      ),
    );
  }
}
