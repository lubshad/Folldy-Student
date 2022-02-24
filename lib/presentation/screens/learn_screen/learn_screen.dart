import 'package:flutter/material.dart';

import 'components/todays_topic_item.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: List.generate(3, (index) => const TodaysTopicItem()),
    );
  }
}
