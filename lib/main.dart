import 'package:basic_template/basic_template.dart';
import 'package:folldy_student/firebase_options.dart';

import 'utils/setup_app.dart';
import 'package:flutter/material.dart';
import 'presentation/route.dart';
import 'presentation/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  setupApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme.setSystemOverlay();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "folldy student",
      theme: AppTheme.theme,
      onGenerateRoute: AppRoute.onGenerateRoute,
      onGenerateInitialRoutes: AppRoute.onGenerateInitialRoute,
      initialRoute: AppRoute.initial,
      // routes: AppRoute.routes,
    );
  }
}
