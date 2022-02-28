import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/components/network_resource.dart';
import 'package:folldy_student/presentation/screens/learn_screen/learn_screen_controller.dart';
import 'package:get/get.dart';

import 'components/course_subjects.dart';
import 'components/learning_path.dart';
import 'components/todays_topic_item.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LearnScreenController());
    LearnScreenController learnScreenController = Get.find();
    learnScreenController.getData();
    return AnimatedBuilder(
      animation: learnScreenController,
      builder: (BuildContext context, Widget? child) {
        return NetworkResource(
          loadingWidget: const LearnScreenShimmer(),
          loading: learnScreenController.isLoading,
          child: Builder(
            builder: (context) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...learnScreenController.learnScreenResponse!.data.topics.map((e) => TodaysTopicItem(topic: e)),
                    const LearningPath(),
                     CourseSubjects(subjects: learnScreenController.learnScreenResponse!.data.subjects),
                  ],
                ),
              );
            }
          ),
        );
      },
    );
  }
}

class LearnScreenShimmer extends StatelessWidget {
  const LearnScreenShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(2, (index) => const TodaysTopicItemShimmer()));
  }
}
