import 'package:flutter/material.dart';
import 'package:protofilio/Features/Navigation/main_scren.dart';
import 'package:protofilio/Features/Tasks/tasks_controller.dart';
import 'package:protofilio/Features/Welcome/welcome_screen.dart';
import 'package:protofilio/core/constants/storge_key.dart';
import 'package:protofilio/core/services/perfrence_manager.dart';
import 'package:protofilio/theme/dark_theme.dart';
import 'package:protofilio/theme/light_theme.dart';
import 'package:protofilio/theme/theme_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PerfrenceManager().init();
  ThemeController().init();
  String? username = PerfrenceManager().getstring(StorgeKey.username);
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
        return ChangeNotifierProvider<TasksController>(
          create: (BuildContext context) {
            return TasksController()..init();
          },
          builder: (context, child) {
            final controller = context.watch<TasksController>();
            return ScreenUtilInit(
              designSize: const Size(375, 809),
              minTextAdapt: true,
              builder: (context, child) {
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
          },
        );
      },
    );
  } // hello git
}
