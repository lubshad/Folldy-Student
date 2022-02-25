import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/theme/theme.dart';

class TrendingTopicListing extends StatelessWidget {
  const TrendingTopicListing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
          vertical: defaultPadding - defaultPaddingSmall),
      children: List.generate(10, (index) => const TrendingTopicItem()),
    );
  }
}

class TrendingTopicItem extends StatelessWidget {
  const TrendingTopicItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPaddingSmall),
        child: Material(
          borderRadius: BorderRadius.circular(defaultPaddingSmall),
          child: InkWell(
            borderRadius: BorderRadius.circular(defaultPaddingSmall),
            onTap: () {},
            child: Row(
              children: [
                AspectRatio(
                  aspectRatio: slideAspectRatio,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(defaultPaddingSmall),
                    child: Image.asset(
                      "assets/slides/s1.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                defaultSpacerHorizontal,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPaddingSmall,
                              vertical: defaultPaddingTiny),
                          decoration: BoxDecoration(
                              color: randomColors.first,
                              borderRadius:
                                  BorderRadius.circular(defaultPaddingTiny)),
                          child: Text("Module 1",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.white))),
                      defaultSpacerTiny,
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              "Oringin and development of banking",
                              style: Theme.of(context).textTheme.headline6,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      defaultSpacerTiny,
                      Text(
                        "Introduction to banking",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
