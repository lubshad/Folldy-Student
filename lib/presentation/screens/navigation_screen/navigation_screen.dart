import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';

import 'navigation_controller.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationController navigationController = Get.find();
    // navigationController.currentScreen = Screens.recordings;
    return AnimatedBuilder(
        animation: navigationController,
        builder: (context, child) {
          return Scaffold(
            body: navigationController.currentScreen.body,
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: navigationController.currentScreen.index,
                type: BottomNavigationBarType.fixed,
                items: Screens.values
                    .map((e) => BottomNavigationBarItem(
                          icon: e.icon,
                          label: e.label,
                        ))
                    .toList(),
                onTap: (index) => navigationController
                    .changeCurrentScreen(Screens.values[index])),
          );
        });
  }
}
