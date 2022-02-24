import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/theme/theme.dart';
import 'package:get/get.dart';

import 'presentation/screens/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AppTheme.setSystemOverlay();
    return GetMaterialApp(
      title: 'Folldy Student',
      theme: AppTheme.theme,
      home: const Home(),
    );
  }
}
