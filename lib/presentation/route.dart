import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/screens/batch_details/batch_details.dart';
import 'package:folldy_student/presentation/screens/home_screen/home_screen.dart';
import 'package:folldy_student/presentation/screens/login_screen/login_screen.dart';
import 'package:folldy_student/presentation/screens/navigation_screen/navigation_screen.dart';
import 'package:folldy_student/presentation/screens/profile_screen/profile_screen.dart';
import 'package:folldy_student/presentation/screens/readmode_screen/readmode_screen.dart';
import 'package:folldy_student/presentation/screens/recording_screen/recording_screen.dart';
import 'package:folldy_student/presentation/screens/recordings/recordings.dart';
import 'package:folldy_student/presentation/screens/register_screen/register_screen.dart';
import 'package:folldy_student/presentation/screens/subject_details/subject_details.dart';
import 'package:folldy_utils/presentation/elements/read_mode_element.dart';

class AppRoute {
  // Routes
  static const String initial = '/';
  static const String loginScreen = "/loginScreen";
  static const String navigation = "/navigation";
  static const String addEditBatch = "/addEditBatch";
  static const String batchDetails = "/batchDetails";
  static const String subjectDetails = "/subjectDetails";
  static const String recordingScreen = "/recordingScreen";
  static const String playerScreen = "/playerScreen";
  static const String recordingListing = "/recordingListing";
  static const String profileScreen = "/profileScreen";
  static const String readmodeScreen = "/readmodeScreen";
  static const String registerScreen = "/registerScreen";

  // onGenerateRoute
  static Route onGenerateRoute(RouteSettings settings) {
    final routeName = getRouteName(settings);
    final arguments = getArguments(settings);
    switch (routeName) {
      case initial:
        return MaterialPageRoute(builder: (context) => const AuthWrapper());
      // case addEditBatch:
      //   return MaterialPageRoute(
      //       builder: (context) =>
      //           AddEditBatchScreen(refreshBatches: arguments as VoidCallback));
      case batchDetails:
        return MaterialPageRoute(
            builder: ((context) => BatchDetailsScreen(
                  batch: arguments as Map<String, dynamic>,
                )));
      case subjectDetails:
        return MaterialPageRoute(
            builder: ((context) => SubjectDetails(subject: arguments)));
      case navigation:
        return MaterialPageRoute(
            builder: ((context) => const NavigationScreen()));
      case recordingScreen:
        return MaterialPageRoute(
            builder: ((context) => RecordingScreen(
                presentationScreenArguments:
                    arguments as PresentationScreenArguments)));
      case profileScreen:
        return MaterialPageRoute(builder: ((context) => const ProfileScreen()));
      case recordingListing:
        return MaterialPageRoute(builder: ((context) => const Recordings()));
      case readmodeScreen:
        return MaterialPageRoute(
            builder: ((context) => ReadmodeScreen(
                  readmodeElements: arguments as List<ReadModeElement>,
                )));
      case registerScreen:
        return MaterialPageRoute(
            builder: ((context) => RegisterScreen(
                  phone: arguments,
                )));
      default:
        return MaterialPageRoute(builder: (context) => const Scaffold());
    }
  }

  static List<Route> onGenerateInitialRoute(String initialRoute) {
    return [
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    ];
  }
}
