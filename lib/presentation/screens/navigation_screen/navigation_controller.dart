import 'package:flutter/cupertino.dart';
import 'package:folldy_student/presentation/screens/recordings/recordings.dart';

// import '../batch_listing/batch_listing.dart';
import '../dashboard_screen/dashboard_screen.dart';
import '../profile_screen/profile_screen.dart';

class NavigationController extends ChangeNotifier {
  Screens currentScreen = Screens.recordings;

  changeCurrentScreen(Screens screen) {
    currentScreen = screen;
    notifyListeners();
  }
}

enum Screens {
  dashboard,
  // batches,
  recordings,
  profile,
}

extension ScreenExtension on Screens {
  Widget get icon {
    switch (this) {
      case Screens.dashboard:
        return const Icon(CupertinoIcons.home);
      // case Screens.batches:
      //   return const Icon(CupertinoIcons.book);
      case Screens.profile:
        return const Icon(CupertinoIcons.profile_circled);
      case Screens.recordings:
        return const Icon(CupertinoIcons.mic);
    }
  }

  String get label {
    switch (this) {
      case Screens.dashboard:
        return 'Dashboard';
      // case Screens.batches:
      //   return "Batches";
      case Screens.profile:
        return 'Profile';
      case Screens.recordings:
        return 'Recordings';
    }
  }

  Widget get body {
    switch (this) {
      case Screens.dashboard:
        return DashboardScreen(navigateToBatches: () {});
      // case Screens.batches:
      //   return BatchListing(
      //     navigateToDashboard: () {},
      //   );
      case Screens.profile:
        return const ProfileScreen();
      case Screens.recordings:
        return const Recordings();
    }
  }
}
