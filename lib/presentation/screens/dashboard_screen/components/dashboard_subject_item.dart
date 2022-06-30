import 'dart:math';

import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folldy_utils/presentation/elements/element_type.dart';
import 'package:folldy_utils/presentation/elements/element_utils.dart';

import '../../../../data/core/api_constants.dart';
import '../../../../utils/constants.dart';
import '../../../route.dart';
import '../../recording_screen/recording_screen.dart';

class DashbordSubjectItem extends StatelessWidget {
  const DashbordSubjectItem({
    Key? key,
    required this.subject,
  }) : super(key: key);
  final dynamic subject;

  @override
  Widget build(BuildContext context) {
    List history = subject["presentations"]["history"];
    List upcomming = subject["presentations"]["upcomming"];
    DateTime startDate = DateTime.parse(subject["batch"]['start']);
    DateTime endDate = DateTime.parse(subject["batch"]['end']);
    return Container(
        decoration: const BoxDecoration(
            color: zircon,
            // boxShadow: defaultShadow,
            borderRadius: BorderRadius.only(
              // bottomLeft: Radius.circular(defaultPaddingSmall),
              // bottomRight: Radius.circular(defaultPaddingSmall),
              topRight: Radius.circular(defaultPadding),
              topLeft: Radius.circular(defaultPadding),
            )),
        margin: const EdgeInsets.only(
          top: defaultPaddingSmall,
          // left: defaultPadding,
          // right: defaultPadding,
          // bottom: defaultPadding
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: defaultPadding,
            left: defaultPadding,
            right: defaultPadding,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: defaultPaddingSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject["name"],
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    defaultSpacerTiny,
                    ColorContainer(
                      color: randomColors[
                          Random().nextInt(randomColors.length - 1)],
                      child: Text(
                        "Module 1",
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    defaultSpacerTiny,
                    Text(
                      "${subject["batch"]["course"]} ${startDate.year}-${endDate.year.toString().substring(2, 4)}",
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Row(),
                    // defaultSpacerSmall,
                    // const StudentsProfileListing()
                  ],
                ),
              ),
              Builder(builder: (context) {
                // if (history.length < 2) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: AspectRatio(
                            aspectRatio: portraitSize.aspectRatio,
                            child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft:
                                        Radius.circular(defaultPaddingSmall)),
                                child: LargeThumbnailItem(
                                    presentation: history[0]))),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: upcomming
                              .take(2)
                              .map((presentation) =>
                                  SmallThumbnail(presentation: presentation))
                              .toList(),
                        ),
                      ),
                    ],
                  );
                // }
                // return Row(
                //   children: [
                //     Expanded(
                //       flex: 1,
                //       child: Column(
                //         children: history
                //             .skip(1)
                //             .map(
                //               (history) => AspectRatio(
                //                   aspectRatio: portraitSize.aspectRatio,
                //                   child: SmallThumbnail(
                //                     presentation: history,
                //                   )),
                //             )
                //             .toList(),
                //       ),
                //     ),
                //     Expanded(
                //       flex: 2,
                //       child: AspectRatio(
                //           aspectRatio: portraitSize.aspectRatio,
                //           child: ClipRRect(
                //               borderRadius: const BorderRadius.only(
                //                   bottomRight:
                //                       Radius.circular(defaultPaddingSmall)),
                //               child: LargeThumbnailItem(
                //                   presentation: upcomming.isEmpty
                //                       ? history.last
                //                       : upcomming[0]))),
                //     ),
                //   ],
                // );
              }),
              Row(
                children: [
                  if (history.length > 1)
                    Padding(
                      padding: const EdgeInsets.all(defaultPaddingSmall),
                      child: Text(
                        "Live",
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 10),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  if (history.length > 1) const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(defaultPaddingSmall),
                    child: Text(
                      "Next up ⌚ 6 hours",
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 10),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class SmallThumbnail extends StatelessWidget {
  const SmallThumbnail({
    Key? key,
    required this.presentation,
  }) : super(key: key);

  final Map<String, dynamic> presentation;

  @override
  Widget build(BuildContext context) {
    if (presentation["thumbnail"]["portrait"] == null) return Container();
    return FittedBox(
      fit: BoxFit.fill,
      child: GestureDetector(
        onTap: () => Get.toNamed(AppRoute.recordingScreen,
            arguments: PresentationScreenArguments(
                presentationId: presentation["id"],
                thumbnail: presentation["thumbnail"]["portrait"])),
        child: ThumbnailItem(
            item: presentation["thumbnail"]["portrait"],
            domainUrl: ApiConstants.domainMediaUrl),
      ),
    );
  }
}

class LargeThumbnailItem extends StatelessWidget {
  const LargeThumbnailItem({
    Key? key,
    required this.presentation,
  }) : super(key: key);

  final Map<String, dynamic> presentation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SmallThumbnail(presentation: presentation),
        Positioned(
          top: defaultPaddingSmall,
          right: defaultPaddingSmall,
          child: Row(
            children: [
              ColorContainer(
                  borderRadius: defaultPaddingSmall,
                  color: opaqueBlack,
                  child: Row(
                    children: [
                      const Icon(
                        CupertinoIcons.rectangle_stack,
                        color: Colors.white,
                        size: defaultPadding,
                      ),
                      defaultSpacerHorizontalTiny,
                      Text(
                        "15",
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.white),
                      )
                    ],
                  )),
              defaultSpacerHorizontalSmall,
              ColorContainer(
                  borderRadius: defaultPaddingSmall,
                  color: opaqueBlack,
                  child: Row(
                    children: [
                      const Icon(
                        CupertinoIcons.play_arrow_solid,
                        color: Colors.white,
                        size: defaultPadding,
                      ),
                      Text(
                        "01:15",
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.white),
                      )
                    ],
                  )),
            ],
          ),
        )
      ],
    );
  }
}

class ColorContainer extends StatelessWidget {
  const ColorContainer({
    Key? key,
    this.color = altoGrey,
    this.borderWidth,
    this.borderRadius = defaultPaddingTiny,
    required this.child,
  }) : super(key: key);
  final Widget child;
  final Color color;
  final double borderRadius;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(defaultPaddingTiny),
        decoration: BoxDecoration(
            border: borderWidth == null ? null : Border.all(color: altoGrey),
            color: color,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: child);
  }
}

List<String> dummyStudents = [
  "https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9ydHJhaXR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cG9ydHJhaXR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cG9ydHJhaXR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cG9ydHJhaXR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1531123897727-8f129e1688ce?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cG9ydHJhaXR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1552374196-c4e7ffc6e126?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8cG9ydHJhaXR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8cG9ydHJhaXR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1521119989659-a83eee488004?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8cG9ydHJhaXR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1521119989659-a83eee488004?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8cG9ydHJhaXR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1580489944761-15a19d654956?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8cG9ydHJhaXR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"
];

class StudentsProfileListing extends StatelessWidget {
  const StudentsProfileListing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dummyStudents.shuffle();
    return LayoutBuilder(builder: (context, constraits) {
      final width = constraits.maxWidth;
      const radius = 20.0;
      int allocatableImageCount =
          (width / ((radius * 2) + defaultPaddingSmall).toInt() - 1).toInt();
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        ...dummyStudents
            .take(allocatableImageCount)
            .map((student) => CircleAvatar(
                  radius: radius,
                  backgroundColor: Colors.transparent,
                  backgroundImage: CachedNetworkImageProvider(student),
                ))
            .toList(),
        CircleAvatar(
          radius: radius,
          backgroundColor: altoGrey,
          child: Text(
            "+\n44",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ]);
    });
  }
}
