import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  AppCache._();

  static AppCache instance = AppCache._();

  late SharedPreferences prefs;

  Future<void> setUp() async {
    prefs = await SharedPreferences.getInstance();
  }
}
