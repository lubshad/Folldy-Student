import 'dart:math';

import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/route.dart';
import 'package:folldy_student/presentation/screens/dashboard_screen/components/dashboard_subject_item.dart';
import 'package:folldy_student/utils/constants.dart';

class BatchItem extends StatelessWidget {
  const BatchItem({Key? key, required this.batch}) : super(key: key);

  final Map<String, dynamic> batch;

  @override
  Widget build(BuildContext context) {
    DateTime startDate = DateTime.parse(batch['start']);
    DateTime endDate = DateTime.parse(batch['end']);
    return Container(
      margin: const EdgeInsets.only(bottom: defaultPaddingSmall),
      child: Material(
        color: Colors.white,
        // elevation: 5,
        // shadowColor: Colors.black,
        borderRadius: BorderRadius.circular(defaultPadding),
        child: InkWell(
          borderRadius: BorderRadius.circular(defaultPadding),
          onTap: () {
            batch["name"] = batch["course"]["name"];
            Get.toNamed(AppRoute.batchDetails, arguments: batch);
          },
          child: Container(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${batch["course"]["name"]}",
                      maxLines: 1,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    defaultSpacerHorizontalTiny,
                    Text(
                      style: Theme.of(context).textTheme.headline6,
                      "${startDate.year}-${endDate.year.toString().substring(2, 4)}",
                    )
                  ],
                ),
                // defaultSpacerTiny,
                Text(
                  batch["name"],
                  style: Theme.of(context).textTheme.caption,
                ),
                defaultSpacerTiny,
                ColorContainer(
                  color:
                      randomColors[Random().nextInt(randomColors.length - 1)],
                  child: Text(
                    "Semester ${batch["liveSemester"]}",
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.white),
                  ),
                ),
                defaultSpacer,
                const StudentsProfileListing(),
                defaultSpacer,
                const SubjectNameListing(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubjectNameListing extends StatelessWidget {
  const SubjectNameListing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List batchSubjects = [
      "Business Reserch Methods",
      "Income Tax and GST",
      "Business Management",
      "Professional Business Skills",
      "Computer Application in Business",
      "Business Communication",
      "Business Law",
    ];
    batchSubjects.shuffle();
    return Wrap(
        spacing: defaultPaddingTiny,
        runSpacing: defaultPaddingTiny,
        children: [
          ...batchSubjects
              .take(3)
              .map(
                (subject) => ColorContainer(
                    borderRadius: defaultPadding,
                    child: Padding(
                      padding: const EdgeInsets.all(defaultPaddingTiny),
                      child: Text(subject,
                          style: Theme.of(context).textTheme.caption!),
                    )),
              )
              .toList(),
          ColorContainer(
              borderRadius: defaultPaddingSmall,
              child: Padding(
                padding: const EdgeInsets.all(defaultPaddingTiny),
                child: Text("+4", style: Theme.of(context).textTheme.caption!),
              )),
          ColorContainer(
              borderRadius: defaultPaddingSmall,
              child: Padding(
                padding: const EdgeInsets.all(defaultPaddingTiny),
                child:
                    Text("🧒 08", style: Theme.of(context).textTheme.caption!),
              ))
        ]);
  }
}

class AddBatchButton extends StatelessWidget {
  const AddBatchButton({Key? key, required this.refreshBatches})
      : super(key: key);

  final VoidCallback refreshBatches;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 5,
      shadowColor: Colors.black,
      borderRadius: BorderRadius.circular(defaultPaddingSmall),
      child: InkWell(
        onTap: () =>
            Get.toNamed(AppRoute.addEditBatch, arguments: refreshBatches),
        borderRadius: BorderRadius.circular(defaultPaddingSmall),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(CupertinoIcons.add_circled),
            defaultSpacerSmall,
            Text(
              "Add New\nBatch",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
