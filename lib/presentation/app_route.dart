import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/screens/set_what_to_study_screen/set_what_to_study_screen.dart';
import 'package:folldy_student/presentation/screens/subject_details_screen/subject_details_screen.dart';

class AppRoute {
  static const setWhatToStudy = '/setWhatToStudy';
  static const subjectDetailsScreen = '/subjectDetailsScreen';

  static Map<String, WidgetBuilder> get  routes => {
    setWhatToStudy: ((context) => const SetWhatToStudyScreen()),
    subjectDetailsScreen: ((context) => const SubjectDetailsScreen()),
  };

}



