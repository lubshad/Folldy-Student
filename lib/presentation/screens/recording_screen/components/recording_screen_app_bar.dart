import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/route.dart';
import 'package:folldy_student/presentation/screens/dashboard_screen/components/dashboard_subject_item.dart';
import 'package:folldy_student/presentation/screens/recording_screen/recording_controller.dart';
import 'package:folldy_student/utils/constants.dart';

class RecordingScreenAppBar extends StatelessWidget {
  const RecordingScreenAppBar({
    Key? key,
    required this.recordingController,
  }) : super(key: key);

  final RecordingController recordingController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          ColorContainer(
              borderRadius: defaultPaddingLarge,
              color: opaqueBlack,
              child: SizedBox(
                width: defaultPaddingLarge,
                height: defaultPaddingLarge,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: Get.back,
                    icon: const Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                    )),
              )),
          const Spacer(),
          ColorContainer(
              borderRadius: defaultPaddingLarge,
              color: opaqueBlack,
              child: SizedBox(
                height: defaultPaddingLarge,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPaddingSmall),
                    child: AnimatedBuilder(
                        animation: recordingController.pageController,
                        builder: (context, child) {
                          int totalPages = recordingController.pages.length;
                          int currentPage =
                              recordingController.currentPageIndex + 1;
                          return Text("$currentPage/$totalPages",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.white));
                        }),
                  ),
                ),
              )),
          defaultSpacerHorizontalSmall,
          ColorContainer(
              borderRadius: defaultPaddingLarge,
              color: opaqueBlack,
              child: SizedBox(
                width: defaultPaddingLarge,
                height: defaultPaddingLarge,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Get.toNamed(AppRoute.readmodeScreen,
                        arguments: recordingController.readmodeElements),
                    icon: const Icon(
                      CupertinoIcons.doc_text,
                      color: Colors.white,
                    )),
              )),
          defaultSpacerHorizontalSmall,
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(dummyStudents[6],
                maxHeight: 200, maxWidth: 200),
          )
        ],
      ),
    );
  }
}
