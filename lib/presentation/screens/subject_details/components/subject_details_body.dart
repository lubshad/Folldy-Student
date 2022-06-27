import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/screens/dashboard_screen/components/dashboard_subject_item.dart';
import 'package:folldy_student/utils/constants.dart';
import 'package:folldy_utils/presentation/elements/element_type.dart';

import 'chapter_presentation_item.dart';
import 'module_chapter_item.dart';

class SubjectDetailsBody extends StatefulWidget {
  const SubjectDetailsBody({
    Key? key,
    required this.modules,
    required this.color,
  }) : super(key: key);

  final List modules;
  final Color color;

  @override
  State<SubjectDetailsBody> createState() => _SubjectDetailsBodyState();
}

class _SubjectDetailsBodyState extends State<SubjectDetailsBody>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: widget.modules.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
            padding: const EdgeInsets.all(defaultPaddingSmall),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  widget.modules.length,
                  (index) => ModuleTabItem(
                        index: index,
                        module: widget.modules[index],
                        color: widget.color,
                        tabController: tabController,
                      )),
            )),
        Expanded(
            child: TabBarView(
                controller: tabController,
                children: widget.modules
                    .map((module) => ChapterListing(
                          chapters: module["chapters"],
                        ))
                    .toList())),
      ],
    );
  }
}

class ModuleTabItem extends StatelessWidget {
  const ModuleTabItem({
    Key? key,
    required this.color,
    required this.module,
    required this.tabController,
    required this.index,
  }) : super(key: key);

  final Map<String, dynamic> module;
  final Color color;
  final TabController tabController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: defaultPaddingSmall),
      child: GestureDetector(
        onTap: () {
          tabController.animateTo(index,
              duration: defaultAnimationDuration, curve: Curves.fastOutSlowIn);
        },
        child: AnimatedBuilder(
            animation: tabController,
            builder: (context, child) {
              return ColorContainer(
                borderWidth: tabController.index == index ? null : 1,
                color: tabController.index == index ? color : Colors.white,
                borderRadius: defaultPaddingLarge,
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: defaultPaddingTiny),
                          alignment: Alignment.center,
                          width: defaultPaddingLarge * .8,
                          height: defaultPaddingLarge * .8,
                          decoration: const BoxDecoration(
                            color: frenchGrey,
                            shape: BoxShape.circle,
                          ),
                          // child: Text(
                          //   (module["module"]).toString(),
                          //   style: Theme.of(context).textTheme.caption,
                          // ),
                        ),
                        Positioned(
                          left: defaultPaddingTiny,
                          right: defaultPaddingTiny,
                          bottom: defaultPaddingTiny,
                          top: defaultPaddingTiny,
                          child: FittedBox(
                            child: CircularProgressIndicator(
                              value: .5,
                              color: color,
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      "Module ${module["module"]}",
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          color: tabController.index == index
                              ? Colors.white
                              : Colors.black),
                    ),
                    defaultSpacerHorizontal,
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class ChapterListing extends StatelessWidget {
  const ChapterListing({
    Key? key,
    required this.chapters,
  }) : super(key: key);

  final List chapters;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: defaultPadding),
        itemCount: chapters.length,
        itemBuilder: (context, index) {
          final Map<String, dynamic> chapter = chapters[index];
          return ModuleChapterItem(
            chapter: chapter,
          );
        });
  }
}

class ChapterPresentationListing extends StatelessWidget {
  const ChapterPresentationListing({
    Key? key,
    required this.presentations,
  }) : super(key: key);

  final List presentations;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(defaultPadding),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: presentations.length,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: defaultPaddingSmall,
            mainAxisSpacing: defaultPaddingLarge,
            crossAxisCount: 2,
            childAspectRatio: Size(portraitSize.width,
                    portraitSize.height + defaultPaddingLarge)
                .aspectRatio),
        itemBuilder: (context, index) {
          return ChapterPresentationItem(
            key: Key(presentations[index]["id"].toString()),
            presentation: presentations[index],
          );
        });
  }
}
