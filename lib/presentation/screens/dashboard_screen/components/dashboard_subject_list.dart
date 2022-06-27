import 'package:flutter/material.dart';

import 'dashboard_subject_item.dart';

class DashboardSubjectList extends StatelessWidget {
  const DashboardSubjectList({Key? key, required this.subjects})
      : super(key: key);

  final List subjects;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: subjects
          .map((subject) => DashbordSubjectItem(subject: subject))
          .toList(),
    );
  }
}
