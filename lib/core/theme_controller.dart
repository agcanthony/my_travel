import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  bool _changeTheme() => _box.read(_key) ?? false;

  _saveTheme(bool isDarkMode) => _box.write(_key, isDarkMode);

  ThemeMode get theme => _changeTheme() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(_changeTheme() ? ThemeMode.light : ThemeMode.dark);
    _saveTheme(_changeTheme() == false);
  }
}
