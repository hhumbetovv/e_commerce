import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/string_constants.dart';
import 'initialize/app_onset.dart';
import 'initialize/app_theme.dart';
import 'screens/splash/splash_view.dart';

void main() {
  AppOnset.init();
  runApp(const ECommerce());
}

class ECommerce extends StatelessWidget {
  const ECommerce({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: StringConstants.appName,
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
    );
  }
}
