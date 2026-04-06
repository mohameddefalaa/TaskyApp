import 'package:flutter/material.dart';
import 'package:protofilio/Screens/main_scren.dart';
import 'package:protofilio/Screens/welcome_screen.dart';
import 'package:protofilio/core/services/perfrence_manager.dart';
import 'package:protofilio/theme/dark_theme.dart';
import 'package:protofilio/theme/light_theme.dart';
import 'package:protofilio/theme/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PerfrenceManager().init();
  ThemeController().init();
  String? username = PerfrenceManager().getstring("Full Name");
  runApp(TaskyApp(username: username));
}

class TaskyApp extends StatelessWidget {
  const TaskyApp({super.key, required this.username});
  final String? username;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, ThemeMode value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: value,

          //isDark == true ? darkTheme : lightTheme\
          home: Scaffold(
            body: username == null ? WelcomeScreen() : MainScren(),

            //: MainScren()
          ),
        );
      },
    );
  }
}
