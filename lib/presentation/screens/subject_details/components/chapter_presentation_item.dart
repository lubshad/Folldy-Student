import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/screens/subject_details/subject_details_controller.dart';
import 'package:folldy_student/utils/constants.dart';
import 'package:folldy_utils/presentation/elements/element_type.dart';
import 'package:folldy_utils/presentation/elements/element_utils.dart';

import '../../../../data/core/api_constants.dart';
import '../../../route.dart';
import '../../recording_screen/recording_screen.dart';

class ChapterPresentationItem extends StatelessWidget {
  const ChapterPresentationItem({
    Key? key,
    required this.presentation,
  }) : super(key: key);

  final Map<String, dynamic> presentation;

  @override
  Widget build(BuildContext context) {
    SubjectDetailsController subjectDetailsController = Get.find();
    return Column(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: portraitSize.aspectRatio,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(defaultPaddingSmall),
              child: FittedBox(
                fit: BoxFit.fill,
                child: GestureDetector(
                  onTap: () => Get.toNamed(AppRoute.recordingScreen,
                      arguments: PresentationScreenArguments(
                          presentationId: presentation["id"],
                          thumbnail: presentation["thumbnail"]["portrait"])),
                  child: presentation["thumbnail"]["portrait"] == null
                      ? Container()
                      : ThumbnailItem(
                          item: presentation["thumbnail"]["portrait"],
                          domainUrl: ApiConstants.domainMediaUrl),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: defaultPaddingLarge,
          child: AnimatedBuilder(
              animation: subjectDetailsController,
              builder: (context, child) {
                // bool onWall = subjectDetailsController.presentationOnWall ==
                //     presentation["id"];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(onWall ? "On Wall" : "Add to wall"),
                    // defaultSpacerHorizontalSmall,
                    Switch(
                        value: subjectDetailsController.presentationOnWall ==
                            presentation["id"],
                        onChanged: (val) => subjectDetailsController
                            .presentationToWall(presentation["id"])),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert,
                          size: defaultPadding,
                        ))
                  ],
                );
              }),
        )
      ],
    );
  }
}
