import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/screens/subject_details/components/subject_details_body.dart';

import '../../../components/title_with_view_all.dart';

class ModuleChapterItem extends StatelessWidget {
  const ModuleChapterItem({
    Key? key,
    required this.chapter,
  }) : super(key: key);

  final Map<String, dynamic> chapter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWithAction(title: chapter["name"]),
        ChapterPresentationListing(
          presentations: chapter["presentations"],
        )
      ],
    );
  }
}
