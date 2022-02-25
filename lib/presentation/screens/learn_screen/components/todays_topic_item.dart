import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:folldy_student/data/models/lean_screen_response.dart';
import 'package:folldy_student/presentation/screens/slide_screen/slide_screen_controller.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../theme/theme.dart';

class TodaysTopicItem extends StatelessWidget {
  const TodaysTopicItem({
    Key? key,
    required this.topic,
  }) : super(key: key);

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1,
        child: Container(
            margin: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPaddingSmall),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultPaddingSmall),
              color: Colors.white,
              boxShadow: defaultShadow,
            ),
            child: Stack(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(defaultPaddingSmall),
                    onTap: () => Get.find<SlideScreenController>().openPlayer(),
                    child: Container(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svgs/subject_icon.svg",
                              ),
                              defaultSpacerHorizontalTiny,
                              Expanded(
                                child: Text(
                                  topic.subject,
                                  style: Theme.of(context).textTheme.caption,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          defaultSpacerTiny,
                          Text(
                            topic.name,
                            style: Theme.of(context).textTheme.headline6,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          defaultSpacerSmall,
                          Expanded(
                            child: Row(children: [
                              AspectRatio(
                                aspectRatio: slideAspectRatio,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      defaultPaddingSmall),
                                  child: Image.asset(
                                    "assets/slides/s1.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              defaultSpacerHorizontal,
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CircleAvatar(
                                    radius: defaultPadding * 1.2,
                                  ),
                                  defaultSpacerTiny,
                                  Text(topic.teacher),
                                  const Spacer(),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: defaultPaddingSmall,
                                          vertical: defaultPaddingTiny),
                                      // alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: randomColors.first,
                                          borderRadius: BorderRadius.circular(
                                              defaultPaddingTiny)),
                                      child: Text(
                                        "Module ${topic.module}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(color: Colors.white),
                                      )),
                                  Text(topic.chapter),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "English/Malayalam",
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                          defaultSpacerTiny,
                                          Text(
                                            "08-10 Mins",
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                        ],
                                      )),
                                      SvgPicture.asset(
                                          "assets/svgs/play_button.svg"),
                                    ],
                                  )
                                ],
                              ))
                            ]),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: PopupMenuButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.more_horiz),
                      itemBuilder: (context) => const [
                            PopupMenuItem(child: Text("Play")),
                            PopupMenuItem(child: Text("Read")),
                            PopupMenuItem(child: Text("Story")),
                            PopupMenuItem(child: Text("Remove")),
                          ]),
                )
              ],
            )));
  }
}

class TodaysTopicItemShimmer extends StatelessWidget {
  const TodaysTopicItemShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1,
        child: Container(
            margin: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPaddingSmall),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultPaddingSmall),
              color: Colors.white,
              boxShadow: defaultShadow,
            ),
            child: Stack(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(defaultPaddingSmall),
                    onTap: () => Get.find<SlideScreenController>().openPlayer(),
                    child: Container(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(.1),
                        highlightColor: Colors.grey.withOpacity(.2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/svgs/subject_icon.svg",
                                ),
                                defaultSpacerHorizontalTiny,
                                Expanded(
                                  child: Container(
                                    height: defaultPadding,
                                    color: Colors.white,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                            defaultSpacerTiny,
                            Container(
                              height: defaultPadding,
                              color: Colors.white,
                            ),
                            defaultSpacerTiny,
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: defaultPadding,
                                    color: Colors.white,
                                  ),
                                ),
                                const Spacer()
                              ],
                            ),
                            defaultSpacerSmall,
                            Expanded(
                              child: Row(children: [
                                AspectRatio(
                                  aspectRatio: slideAspectRatio,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        defaultPaddingSmall),
                                    child: Container(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                defaultSpacerHorizontal,
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CircleAvatar(
                                      radius: defaultPadding * 1.2,
                                    ),
                                    defaultSpacerTiny,
                                    Container(
                                      color: Colors.white,
                                      child: const Text("Fahis K"),
                                    ),
                                    const Spacer(),
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: defaultPaddingSmall,
                                            vertical: defaultPaddingTiny),
                                        // alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: randomColors.first,
                                            borderRadius: BorderRadius.circular(
                                                defaultPaddingTiny)),
                                        child: Text(
                                          "Module 1",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(color: Colors.white),
                                        )),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: defaultPaddingTiny),
                                            color: Colors.white,
                                            height: defaultPadding,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    color: Colors.white,
                                                    height: defaultPaddingSmall,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            defaultSpacerTiny,
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    color: Colors.white,
                                                    height: defaultPaddingSmall,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                        defaultSpacerHorizontalTiny,
                                        SvgPicture.asset(
                                            "assets/svgs/play_button.svg"),
                                      ],
                                    )
                                  ],
                                ))
                              ]),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.withOpacity(.1),
                    highlightColor: Colors.grey.withOpacity(.3),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.more_horiz),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            )));
  }
}
