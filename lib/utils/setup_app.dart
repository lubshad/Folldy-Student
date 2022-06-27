import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';

import '../di.dart';
import '../presentation/theme.dart';

setupApp() {
  // setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();
  setupLogger();
  DependencyInjection.inject();
  for (var element in availableFonts) {
    logger.info(element);
  }
}
