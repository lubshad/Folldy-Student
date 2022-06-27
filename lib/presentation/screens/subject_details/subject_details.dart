import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/components/error_message_with_retry.dart';
import 'package:folldy_student/presentation/screens/subject_details/subject_details_controller.dart';
import 'package:folldy_student/utils/constants.dart';

import 'components/subject_details_body.dart';

class SubjectDetails extends StatelessWidget {
  const SubjectDetails({
    Key? key,
    required this.subject,
  }) : super(key: key);
  final Map<String, dynamic> subject;

  @override
  Widget build(BuildContext context) {
    SubjectDetailsController subjectDetailsController = Get.find();
    subjectDetailsController.makeLoading();
    subjectDetailsController.subject = subject;
    subjectDetailsController.getData();
    return Scaffold(
        appBar: SubjectDetailsAppbar(subject: subject),
        body: AnimatedBuilder(
            animation: subjectDetailsController,
            builder: (context, child) {
              return NetworkResource(
                errorWidget: Builder(builder: (context) {
                  return ErrorMessageWithRetry(
                      error: subjectDetailsController.appError!,
                      retry: subjectDetailsController.retry);
                }),
                error: subjectDetailsController.appError,
                isLoading: subjectDetailsController.isLoading,
                child: SubjectDetailsBody(
                    color: subject["color"],
                    modules: subjectDetailsController.modules),
              );
            }));
  }
}

class SubjectDetailsAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const SubjectDetailsAppbar({Key? key, required this.subject})
      : super(key: key);
  final Map<String, dynamic> subject;
  @override
  Widget build(BuildContext context) {
    DateTime startDate = DateTime.parse(subject["batch"]['start']);
    DateTime endDate = DateTime.parse(subject["batch"]['end']);
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        decoration: BoxDecoration(
            color: subject["color"],
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(defaultPaddingLarge * 2))),
        child: SafeArea(
            child: Row(
          children: [
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: Get.back,
                icon: const Icon(
                  CupertinoIcons.arrow_left_circle_fill,
                  color: Colors.white,
                )),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          subject["name"],
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  Text(
                    "${subject["batch"]["course"]} ${startDate.year}-${endDate.year.toString().substring(2, 4)}  |  Semester ${subject["semester"]}",
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: altoGrey),
                  )
                ],
              ),
            )
          ],
        )));
  }

  @override
  Size get preferredSize => AppBar().preferredSize * 1.5;
}
