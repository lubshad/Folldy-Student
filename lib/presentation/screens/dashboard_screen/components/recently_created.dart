import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/route.dart';
import 'package:folldy_student/presentation/screens/dashboard_screen/components/recently_created_item.dart';
import 'package:folldy_student/utils/constants.dart';

import '../../../components/title_with_view_all.dart';

class RecentlyCreated extends StatelessWidget {
  const RecentlyCreated({Key? key, required this.presentations})
      : super(key: key);
  final List presentations;

  @override
  Widget build(BuildContext context) {
    if (presentations.isEmpty) {
      return Container();
    }
    return Container(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      color: zircon,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWithAction(
            title: "Recently Created",
            onPressed: () => Get.toNamed(AppRoute.recordingListing),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding - defaultPaddingTiny),
            scrollDirection: Axis.horizontal,
            child: Row(
                children: presentations
                    .map((presentation) =>
                        RecentlyCreatedItem(presentation: presentation))
                    .toList()),
          )
        ],
      ),
    );
  }
}
