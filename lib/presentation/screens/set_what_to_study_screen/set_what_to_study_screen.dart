import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/theme/theme.dart';
import 'package:get/get.dart';

import 'components/subject.dart';

class SetWhatToStudyScreen extends StatelessWidget {
  const SetWhatToStudyScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: Get.back, icon: const Icon(Icons.arrow_back_ios)),
              Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding,
                  ),
                  decoration: BoxDecoration(
                    color: porcelain,
                    borderRadius: BorderRadius.circular(defaultPaddingSmall),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(defaultPaddingSmall),
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Text("4",
                              style:
                                  Theme.of(context).textTheme.headline6Bold)),
                      defaultSpacerHorizontalTiny,
                      Text(
                        "Pick your free topics today",
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    ],
                  )),
            ],
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
                child: Column(
          children: List.generate(5, (index) => const Subject()),
        )))
      ],
    ));
  }
}
