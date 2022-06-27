import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/screens/batch_details/batch_details_controller.dart';
import 'package:folldy_student/utils/constants.dart';

class SemesterSubject extends StatelessWidget {
  const SemesterSubject(
      {Key? key, required this.batchDetailsController, required this.subject})
      : super(key: key);

  final Map<String, dynamic> subject;
  final BatchDetailsController batchDetailsController;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(defaultPaddingTiny),
      padding: const EdgeInsets.all(defaultPadding),
      width: MediaQuery.of(context).size.width * .7,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: defaultShadow,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              subject["name"],
              maxLines: 2,
            ),
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: Text("Add To Dashboard"),
              )
            ],
            onSelected: (value) {
              if (value == 1) {
                batchDetailsController.addSubjectToDashboard(subject);
              }
            },
            icon: const Icon(Icons.more_horiz),
          )
        ],
      ),
    );
  }
}
