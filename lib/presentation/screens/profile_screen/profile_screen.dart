import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';

import '../login_screen/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Get.find<AuthController>().logout();
              Get.until((route) => route.isFirst);
            },
            child: const Text("Logout")),
      ),
    );
  }
}
