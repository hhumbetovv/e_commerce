import 'package:e_commerce/initialize/app_cache.dart';
import 'package:flutter/material.dart';

class AppOnset {
  const AppOnset._();

  static void init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await AppCache.instance.setUp();
  }
}
