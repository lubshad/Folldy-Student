import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import '../../dashboard_screen/components/dashboard_subject_item.dart';

class BatchStudents extends StatelessWidget {
  const BatchStudents({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultPaddingSmall),
      padding: const EdgeInsets.only(
          top: defaultPadding, left: defaultPadding, right: defaultPadding),
      decoration: BoxDecoration(
          color: zircon,
          borderRadius: BorderRadius.circular(defaultPaddingSmall)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Students (40)",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          defaultSpacer,
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.share),
                    label: const Text("Invite")),
              ),
              defaultSpacerHorizontalSmall,
              Expanded(
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          primary: altoGrey, elevation: 0),
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.check_mark,
                        color: Colors.black,
                      ),
                      label: const Text(
                        "Approve",
                        style: TextStyle(color: Colors.black),
                      ))),
            ],
          ),
          defaultSpacer,
          ...dummyStudents
              .take(6)
              .map((student) => ListTile(
                    dense: true,
                    leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(student),
                    ),
                    title: const Text("Student"),
                    subtitle: const Text("987654321"),
                    trailing: const Text("Active"),
                  ))
              .toList(),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero)),
              onPressed: () {},
              child: Text(
                "View more",
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          )
        ],
      ),
    );
  }
}
