import 'package:flutter/material.dart';

import 'components/course_subjects.dart';
import 'components/learning_path.dart';
import 'components/todays_topic_item.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(
            3,
            (index) => const TodaysTopicItem(),
          ),
          const LearningPath(),
          const CourseSubjects(),
        ],
      ),
    );
  }
}


