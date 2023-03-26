import '../initialize/app_cache.dart';

enum CacheItems {
  favorites;

  List<String> get getStringList => AppCache.instance.prefs.getStringList(name) ?? [];
  // String get getString => AppCache.instance.prefs.getString(name) ?? '';
  // int get getInt => AppCache.instance.prefs.getInt(name) ?? 0;
  // double get getDouble => AppCache.instance.prefs.getDouble(name) ?? 0;
  // bool get getBool => AppCache.instance.prefs.getBool(name) ?? false;

  Future<bool> setStringList(List<String> list) => AppCache.instance.prefs.setStringList(name, list);
  // Future<bool> setString(String value) => AppCache.instance.prefs.setString(name, value);
  // Future<bool> setInt(int value) => AppCache.instance.prefs.setInt(name, value);
  // Future<bool> setDouble(double value) => AppCache.instance.prefs.setDouble(name, value);
  // Future<bool> setBool(bool value) => AppCache.instance.prefs.setBool(name, value);
}
