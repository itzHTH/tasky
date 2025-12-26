import 'package:flutter/material.dart';

import 'shard_pers.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeValueNotifier = ValueNotifier(
    ThemeMode.dark,
  );

  static void init() {
    bool result =
        SharedPrefsHelper.instance.getBoolValue("isDarkTheme") ?? true;
    themeValueNotifier.value = result ? ThemeMode.dark : ThemeMode.light;
  }

  static Future<void> toggleTheme() async {
    if (themeValueNotifier.value == ThemeMode.dark) {
      themeValueNotifier.value = ThemeMode.light;
      await SharedPrefsHelper.instance.setBoolValue("isDarkTheme", false);
    } else {
      themeValueNotifier.value = ThemeMode.dark;
      await SharedPrefsHelper.instance.setBoolValue("isDarkTheme", true);
    }
  }

  static bool isDark() => themeValueNotifier.value == ThemeMode.dark;
}
