import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protofilio/Features/Home/components/all_tasks_list_widget.dart';
import 'package:protofilio/Features/Home/components/home_controller.dart';
import 'package:protofilio/Features/Add_Task/add_task_Screen.dart';
import 'package:protofilio/Features/Home/components/archived_task_widget.dart';
import 'package:protofilio/Features/Home/components/highpreprityt_task_widget.dart';
import 'package:protofilio/theme/theme_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController()..init(),
      child: Scaffold(
        floatingActionButton: SizedBox(
          height: 40,
          child: Builder(
            builder: (context) {
              return FloatingActionButton.extended(
                onPressed: () async {
                  final bool? result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AddTask();
                      },
                    ),
                  );
                  if (result != null && result == true) {
                    // to confirm if the user do action or no. by save the value which was comming froM navigation.              log("this is $result");

                    context.read<HomeController>().gettaskname();
                  } else {}
                },

                icon: SvgPicture.asset(
                  "assets/images/PLUS_icon.svg",
                  height: 18,
                  width: 18,
                ),
                label: Text(
                  "Add New Task",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
          ),
        ),

        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Selector<HomeController, File?>(
                                selector:
                                    (
                                      BuildContext context,
                                      HomeController controoller,
                                    ) {
                                      return controoller.selectedimage;
                                    },
                                builder:
                                    (
                                      BuildContext context,
                                      File? selectedimage,
                                      Widget? child,
                                    ) {
                                      return ClipOval(
                                        child: SizedBox.fromSize(
                                          size: Size.fromRadius(35),
                                          child:
                                              selectedimage != null &&
                                                  selectedimage.existsSync()
                                              ? Image.file(selectedimage)
                                              : SvgPicture.asset(
                                                  "assets/images/person.svg",
                                                  alignment:
                                                      AlignmentGeometry.center,
                                                  fit: BoxFit.cover,

                                                  height: 50,
                                                  width: 50,
                                                ),
                                        ),
                                      );
                                    },
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Selector<HomeController, String?>(
                                      selector:
                                          (context, HomeController controller) {
                                            return controller.finalname;
                                          },
                                      builder: (context, finalname, child) {
                                        return Text(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          "Good Evening, ${finalname?.split(' ').first ?? ''}", //تم تحويل الاسمك الي ليست اوف كلمات وبالتالي طلبنا منه الكلمة الاولي
                                          style: TextTheme.of(
                                            context,
                                          ).titleMedium,
                                        );
                                      },
                                    ),
                                    Selector<HomeController, String?>(
                                      selector:
                                          (context, HomeController controller) {
                                            return controller.finalbio;
                                          },
                                      builder: (context, finalbio, child) {
                                        return Text(
                                          overflow: TextOverflow.clip,
                                          finalbio ??
                                              'One task at a time. One step closer.',
                                          style: TextTheme.of(
                                            context,
                                          ).bodyMedium,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              InkWell(
                                onTap: () {
                                  ThemeController.toggletheme();
                                },
                                child: CircleAvatar(
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.surface,

                                  child:
                                      ThemeController.themeNotifier.value ==
                                          ThemeMode.dark
                                      ? SvgPicture.asset(
                                          "assets/images/moon.svg",
                                          height: 20,
                                          width: 16,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                        )
                                      : SvgPicture.asset(
                                          "assets/images/sun.svg",
                                          height: 20,
                                          width: 16,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                        ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          Text(
                            overflow: TextOverflow.clip,
                            "Yuhuu ,Your work Is  ",
                            style: TextTheme.of(context).headlineLarge,
                          ),
                          Row(
                            children: [
                              Text(
                                overflow: TextOverflow.clip,
                                "almost done !   ",
                                style: TextTheme.of(context).headlineLarge,
                              ),
                              const SizedBox(width: 8),

                              SvgPicture.asset(
                                "assets/images/waving-hand.svg",

                                height: 32,
                                width: 32,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ArchivedTask(
                            // compleatedtasks: value.compleatedtasks,
                            // totalTasks: value.totalTasks,
                            // percent: value.percent,
                            // alltasks: value.allDataTaska,
                            // highPriorityTasksList: value.allDataTaska,
                          ),
                          const SizedBox(height: 8),
                          HighPeriorityTask(),
                          const SizedBox(height: 24),
                          Text(
                            'My Tasks',
                            style: TextTheme.of(context).titleLarge,
                          ),

                          // const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const AllTasksListWidget(),
          ],
        ),
      ),
    );
  }
}
