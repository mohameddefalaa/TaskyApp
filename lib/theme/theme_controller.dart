import 'package:flutter/material.dart';
import 'package:protofilio/core/services/perfrence_manager.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );
  void init() {
    bool result = PerfrenceManager().getbool('isDark') ?? true;
    themeNotifier.value = result ? ThemeMode.dark : ThemeMode.light;
  }

  static void toggletheme() async {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      await PerfrenceManager().setbool('isDark', false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      await PerfrenceManager().setbool('isDark', true);
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
