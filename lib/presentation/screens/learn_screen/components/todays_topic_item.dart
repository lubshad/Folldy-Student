import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:folldy_student/presentation/screens/slide_screen/slide_screen_controller.dart';
import 'package:get/get.dart';

import '../../../theme/theme.dart';

class TodaysTopicItem extends StatelessWidget {
  const TodaysTopicItem({
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
                                  "Banking and Insurance",
                                  style: Theme.of(context).textTheme.caption,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          defaultSpacerTiny,
                          Text(
                            "Introduction to Companies Act, 1887",
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
                                  const Text("Fahis K"),
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
                                  const Text("Introduction To Banking"),
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
