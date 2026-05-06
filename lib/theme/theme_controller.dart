import 'package:flutter/material.dart';
import 'package:protofilio/core/constants/storge_key.dart';
import 'package:protofilio/core/services/perfrence_manager.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );
  void init() {
    bool result = PerfrenceManager().getbool(StorgeKey.themeapp) ?? true;
    themeNotifier.value = result ? ThemeMode.dark : ThemeMode.light;
  }

  static void toggletheme() async {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      await PerfrenceManager().setbool(StorgeKey.themeapp, false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      await PerfrenceManager().setbool(StorgeKey.themeapp, true);
    }
  }

  static bool isdark() {
    /* if (themeNotifier.value == ThemeMode.dark) {
      return true;
    } else {
      return false;
    }
  }*/

    return themeNotifier.value == ThemeMode.dark ? true : false;
  }
}
