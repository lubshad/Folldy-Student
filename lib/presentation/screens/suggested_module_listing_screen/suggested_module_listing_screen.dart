import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/components/title_text.dart';
import 'package:folldy_student/presentation/theme/theme.dart';

class SuggestedModuleListing extends StatelessWidget {
  const SuggestedModuleListing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(4, (index) => const SuggestedModuleItem()),
    );
  }
}

class SuggestedModuleItem extends StatelessWidget {
  const SuggestedModuleItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        defaultSpacer,
        Container(
            margin: const EdgeInsets.only(left: defaultPadding),
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPaddingTiny),
            decoration: BoxDecoration(
                color: randomColors.first,
                borderRadius: BorderRadius.circular(defaultPaddingTiny)),
            child: Text(
              "Module 1",
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Colors.white),
            )),
        Row(
          children: [
            const Expanded(
              child: TitleText(
                text: "Introduction to Banking",
                padding: false,
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
            SizedBox(
              height: defaultPadding * 1.5,
              child: TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      side: const BorderSide(
                        color: Colors.black,
                      )),
                  onPressed: () {},
                  child: const Text("Read")),
            ),
            defaultSpacerHorizontalSmall,
          ],
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding - defaultPaddingTiny,
              vertical: defaultPaddingSmall),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              5,
              (index) => Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: defaultPaddingTiny),
                width: width * .3,
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: slideAspectRatio,
                      child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(defaultPaddingSmall),
                          child: Image.asset(
                            "assets/slides/s1.png",
                            fit: BoxFit.cover,
                          )),
                    ),
                    defaultSpacerTiny,
                    Text(
                      "Introduction to Companies act 2013",
                      maxLines: 1,
                      style: Theme.of(context).textTheme.caption,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
