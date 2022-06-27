import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/screens/batch_details/batch_details_controller.dart';
import 'package:folldy_student/utils/constants.dart';

class TeacherSelectionBottomSheet extends StatelessWidget {
  const TeacherSelectionBottomSheet({
    Key? key,
    required this.batchDetailsController,
  }) : super(key: key);

  final BatchDetailsController batchDetailsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: batchDetailsController,
        builder: (context, child) {
          final availableTeachers = batchDetailsController.availableTeachers
              .where((element) => element["added"] == false)
              .toList();
          return Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: availableTeachers.length,
                      itemBuilder: ((context, index) =>
                          Builder(builder: (context) {
                            final teacher = availableTeachers[index];
                            return CheckboxListTile(
                                value: teacher["selected"] == true,
                                onChanged: (value) {
                                  teacher["selected"] = value;
                                  batchDetailsController.makeNotLoading();
                                },
                                title: Text(teacher["username"]));
                          }))),
                ),
                Row(
                  children: [
                    defaultSpacerHorizontal,
                    Expanded(
                      child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.share),
                          label: const Text("Invite")),
                    ),
                    defaultSpacerHorizontal,
                    Expanded(
                      child: ElevatedButton.icon(
                          onPressed: batchDetailsController.addSelectedTeachers,
                          icon: const Icon(CupertinoIcons.add),
                          label: const Text("Add")),
                    ),
                    defaultSpacerHorizontal,
                  ],
                )
              ],
            ),
          );
        });
  }
}
