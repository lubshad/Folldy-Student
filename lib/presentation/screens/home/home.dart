import 'package:flutter/material.dart';

import '../find_screen/find_screen.dart';
import '../learn_screen/learn_screen.dart';
import '../slide_screen/slide_screen.dart';
import 'components/home_app_bar.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: HomeAppbar(
                tabController: tabController,
              )),
          Positioned(
            top: kToolbarHeight + statusBarHeight,
            left: 0,
            right: 0,
            bottom: 0,
            child: TabBarView(controller: tabController, children: const [
              LearnScreen(),
              FindScreen(),
            ]),
          ),
          const Positioned(bottom: 0, right: 0, left: 0, child: SlideScreen())
        ],
      ),
    );
  }
}
