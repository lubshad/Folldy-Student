import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/screens/batch_listing/batch_listing.dart';

import '../dashboard_screen/dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: TabBarView(controller: tabController, children: [
          DashboardScreen(
            navigateToBatches: () => tabController.animateTo(1),
          ),
          BatchListing(
            navigateToDashboard: () => tabController.animateTo(0),
          ),
        ]),
      ),
    );
  }

  Future<bool> onWillPop() {
    bool pop = tabController.index == 0;
    if (!pop) {
      tabController.animateTo(0);
    }
    return Future.value(pop);
  }
}
