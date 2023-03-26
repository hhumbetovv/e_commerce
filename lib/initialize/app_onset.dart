import 'package:flutter/material.dart';

import 'app_cache.dart';

class AppOnset {
  const AppOnset._();

  static void init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await AppCache.instance.setUp();
  }
}
