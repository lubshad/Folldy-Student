import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/utils/constants.dart';

import '../../dashboard_screen/components/dashboard_subject_item.dart';
import '../batch_details_controller.dart';

class BatchTeachers extends StatelessWidget {
  const BatchTeachers({
    Key? key,
    required this.batchDetailsController,
  }) : super(key: key);

  final BatchDetailsController batchDetailsController;

  @override
  Widget build(BuildContext context) {
    List teachers = batchDetailsController.availableTeachers
        .where((element) => element["added"] == true)
        .toList();
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: defaultPaddingSmall),
        padding: const EdgeInsets.only(
            top: defaultPadding,
            left: defaultPadding,
            right: defaultPadding,
            bottom: defaultPadding),
        decoration: BoxDecoration(
            color: zircon,
            borderRadius: BorderRadius.circular(defaultPaddingSmall)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Teachers (${teachers.length})",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            GridView(
                padding: const EdgeInsets.only(top: defaultPadding),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: defaultPaddingSmall,
                  crossAxisSpacing: defaultPaddingSmall,
                ),
                children: [
                  ...teachers
                      .map((teacher) => Column(children: [
                            Expanded(
                                child: CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                  dummyStudents[teachers.indexOf(teacher)]),
                              radius: defaultPaddingLarge,
                            )),
                            defaultSpacerTiny,
                            Text(
                              teacher["username"],
                              style: Theme.of(context).textTheme.caption,
                            )
                          ]))
                      .toList(),
                  Column(children: [
                    Expanded(
                        child: InkWell(
                      onTap: batchDetailsController.showTeacherList,
                      child: const CircleAvatar(
                        backgroundColor: contessa,
                        // backgroundImage:
                        //     CachedNetworkImageProvider(teacher),
                        radius: defaultPaddingLarge,
                        child: Icon(
                          CupertinoIcons.add,
                          color: Colors.white,
                        ),
                      ),
                    )),
                    defaultSpacerTiny,
                    Text(
                      "",
                      style: Theme.of(context).textTheme.caption,
                    )
                  ])
                ]),
            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: TextButton(
            //     style: ButtonStyle(
            //         padding: MaterialStateProperty.all(EdgeInsets.zero)),
            //     onPressed: () {},
            //     child: Text(
            //       "View more",
            //       style: Theme.of(context).textTheme.caption,
            //     ),
            //   ),
            // )
          ],
        ));
  }
}
