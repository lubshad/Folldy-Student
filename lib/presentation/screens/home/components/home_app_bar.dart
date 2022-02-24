import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:folldy_student/presentation/theme/theme.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SizedBox(
          height: kToolbarHeight,
          child: AnimatedBuilder(
            animation: tabController.animation!,
            builder: (BuildContext context, Widget? child) {
              return Stack(
                children: [
                  Positioned(
                    left: Tween<double>(begin: 0, end: -width / 2)
                        .evaluate(tabController.animation!),
                    top: 0,
                    bottom: 0,
                    child: Opacity(
                      opacity: Tween<double>(begin: 1, end: 0)
                          .evaluate(tabController.animation!),
                      child: SizedBox(
                        width: width,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon:
                                    SvgPicture.asset("assets/svgs/person.svg")),
                            IconButton(
                                onPressed: () {},
                                icon:
                                    SvgPicture.asset("assets/svgs/story.svg")),
                            IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                    "assets/svgs/announcement.svg")),
                            const Spacer(),
                            TextButton.icon(
                                onPressed: () => tabController.animateTo(1,
                                    curve: Curves.fastOutSlowIn,
                                    duration: defaultAnimationDuration),
                                label: const Icon(
                                  Icons.chevron_right,
                                  color: Colors.red,
                                ),
                                icon: Text(
                                  "Find",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.blueGrey),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: Tween<double>(begin: -width / 2, end: 0)
                        .evaluate(tabController.animation!),
                    child: Opacity(
                      opacity: Tween<double>(begin: 0, end: 1)
                          .evaluate(tabController.animation!),
                      child: SizedBox(
                        width: width,
                        child: Row(
                          children: [
                            TextButton.icon(
                                onPressed: () => tabController.animateTo(0,
                                    curve: Curves.fastOutSlowIn,
                                    duration: defaultAnimationDuration),
                                icon: const Icon(
                                  Icons.chevron_left,
                                  color: Colors.red,
                                ),
                                label: Text(
                                  "Learn",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.blueGrey),
                                )),
                            const Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                    "assets/svgs/announcement.svg")),
                            IconButton(
                                onPressed: () {},
                                icon:
                                    SvgPicture.asset("assets/svgs/search.svg")),
                            IconButton(
                                onPressed: () {},
                                icon:
                                    SvgPicture.asset("assets/svgs/person.svg")),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}
