import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/screens/set_what_to_study_screen/set_what_to_study_screen.dart';

class AppRoute {
  static const setWhatToStudy = '/setWhatToStudy';

  static Map<String, WidgetBuilder> get  routes => {
    setWhatToStudy: ((context) => const SetWhatToStudyScreen()),
  };

}

