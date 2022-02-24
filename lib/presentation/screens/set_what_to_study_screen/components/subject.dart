import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/theme/theme.dart';

import '../../../components/title_text.dart';

class Subject extends StatelessWidget {
  const Subject({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        defaultSpacer,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TitleText(
              text: "Banking and Insurance",
              padding: false,
            ),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.add_box_outlined))
          ],
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding - defaultPaddingTiny),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
                5,
                (index) => Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: defaultPaddingTiny),
                    width: width * .3,
                    child: AspectRatio(
                        aspectRatio: slideAspectRatio * .8,
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
                                ),
                              ),
                            ),
                            const Spacer(),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius:
                                    BorderRadius.circular(defaultPaddingTiny),
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          defaultPaddingTiny),
                                      border: Border.all(color: Colors.green)),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: defaultPaddingSmall),
                                  child: const Text("Add Now"),
                                ),
                              ),
                            )
                          ],
                        )))),
          ),
        )
      ],
    );
  }
}
