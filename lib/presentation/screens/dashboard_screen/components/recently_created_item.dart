import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/data/core/api_constants.dart';
import 'package:folldy_student/presentation/route.dart';
import 'package:folldy_student/presentation/screens/recording_screen/recording_screen.dart';
import 'package:folldy_utils/presentation/elements/element_type.dart';
import 'package:folldy_utils/presentation/elements/element_utils.dart';

import '../../../../utils/constants.dart';

class RecentlyCreatedItem extends StatelessWidget {
  const RecentlyCreatedItem({Key? key, required this.presentation})
      : super(key: key);

  final Map<String, dynamic> presentation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoute.recordingScreen,
          arguments: PresentationScreenArguments(
              presentationId: presentation["id"],
              thumbnail: presentation["thumbnail"]["portrait"])),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: defaultPaddingTiny),
        width: MediaQuery.of(context).size.width * 0.4,
        child: AspectRatio(
            aspectRatio: portraitSize.aspectRatio,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(defaultPaddingSmall),
              child: FittedBox(
                fit: BoxFit.fill,
                child: ThumbnailItem(
                    item: presentation["thumbnail"]["portrait"],
                    domainUrl: ApiConstants.domainMediaUrl),
              ),
            )),
      ),
    );
  }
}
