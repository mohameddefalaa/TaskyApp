import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protofilio/Features/Home/components/home_controller.dart';
import 'package:protofilio/Models/task_model.dart';
import 'package:protofilio/Features/Add_Task/add_task_Screen.dart';
import 'package:protofilio/core/constants/storge_key.dart';
import 'package:protofilio/core/services/perfrence_manager.dart';
import 'package:protofilio/Features/Home/components/archived_task_widget.dart';
import 'package:protofilio/Features/Home/components/custome_svg.dart';
import 'package:protofilio/Features/Home/components/highpreprityt_task_widget.dart';
import 'package:protofilio/core/components/task_item.dart';
import 'package:protofilio/theme/theme_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController()..init(),
      child: Consumer<HomeController>(
        builder: (BuildContext context, value, Widget? child) {
          final HomeController controller = context.read<HomeController>();
          return Scaffold(
            floatingActionButton: SizedBox(
              height: 40,
              child: FloatingActionButton.extended(
                onPressed: () async {
                  final bool? result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AddTask(false);
                      },
                    ),
                  );
                  if (result != null && result == true) {
                    // to confirm if the user do action or no. by save the value which was comming froM navigation.              log("this is $result");

                    controller.gettaskname();
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipOval(
                                    child: SizedBox.fromSize(
                                      size: Size.fromRadius(35),
                                      child:
                                          value.selectedimage != null &&
                                              value.selectedimage!.existsSync()
                                          ? Image.file(value.selectedimage!)
                                          : SvgPicture.asset(
                                              "assets/images/person.svg",
                                              alignment:
                                                  AlignmentGeometry.center,
                                              fit: BoxFit.cover,

                                              height: 50,
                                              width: 50,
                                            ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          "Good Evening, ${value.finalname?.split(' ').first ?? ''}", //تم تحويل الاسمك الي ليست اوف كلمات وبالتالي طلبنا منه الكلمة الاولي
                                          style: TextTheme.of(
                                            context,
                                          ).titleMedium,
                                        ),
                                        Text(
                                          overflow: TextOverflow.clip,
                                          value.finalbio ??
                                              'One task at a time. One step closer.',
                                          style: TextTheme.of(
                                            context,
                                          ).bodyMedium,
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
                                compleatedtasks: value.compleatedtasks,
                                totalTasks: value.totalTasks,
                                percent: value.percent,
                                alltasks: value.allDataTaska,
                                highPriorityTasksList: value.allDataTaska,
                              ),
                              const SizedBox(height: 8),
                              HighPeriorityTask(
                                onDelete: (id) async {
                                  value.highPriorityTasksList.removeWhere(
                                    (e) => e.id == id,
                                  );
                                  final allData = PerfrenceManager().getstring(
                                    StorgeKey.tasksdata,
                                  );
                                  if (allData != null) {
                                    final alljsondata =
                                        jsonDecode(allData) as List<dynamic>;
                                    List<TaskModel> highPreiortyTaskslIST =
                                        alljsondata
                                            .map((e) => TaskModel.fromjson(e))
                                            .toList();

                                    highPreiortyTaskslIST.removeWhere(
                                      (element) => element.id == id,
                                    );

                                    await PerfrenceManager().setstring(
                                      StorgeKey.tasksdata,
                                      jsonEncode(highPreiortyTaskslIST),
                                    );
                                  }
                                },
                                percent: controller.calculatepercentage,
                                highPriorityTasksList: value.allDataTaska
                                    .where((e) => e.isHighpreority == true)
                                    .toList(),
                                //compleatedtasks: compleatedtasks,
                              ),
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
                value.allDataTaska.isNotEmpty
                    ? SliverPadding(
                        padding: EdgeInsetsGeometry.only(bottom: 75),
                        sliver: SliverList.builder(
                          itemCount: value.allDataTaska.length,
                          itemBuilder: (context, index) {
                            final normaltasks = value.allDataTaska[index];
                            return TaskItem(
                              onEdite: () {
                                controller.gettaskname();
                              },
                              model: normaltasks,
                              onDelete: (id) async {
                                value.allDataTaska.removeWhere(
                                  (task) => task.id == id,
                                );
                                List<TaskModel> alltasks = [];
                                alltasks.addAll(value.allDataTaska);
                                final jsonupdate = alltasks
                                    .map((elemnt) => elemnt.toJson())
                                    .toList();
                                await PerfrenceManager().setstring(
                                  StorgeKey.tasksdata,
                                  jsonEncode(jsonupdate),
                                );

                                controller.calculatepercentage();
                              },
                              taskTitle: normaltasks.taskName,
                              taskDesc: normaltasks.taskDesc,
                              isdone: normaltasks.iSDONE,
                              onchange: (val) {
                                controller.toggleTaskStatus(
                                  normaltasks,
                                  val ?? false,
                                );
                              },
                            );
                          },
                        ),
                      )
                    : SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Center(
                              child: CustomeSvg.withoutcolor(
                                path: 'assets/images/NOTASK.svg',
                                height: 100,
                              ),

                              // SvgPicture.asset(
                              //   'assets/images/NOTASK.svg',
                              //   height: 100,
                              //   color: AppColor.primaryDarkText,
                              //   width: 100,
                              // ),
                            ),

                            const SizedBox(height: 8),
                            Text(
                              "Please Add A new Task Now Let's Go",
                              style: TextTheme.of(context).labelLarge,
                            ),
                          ],
                        ),
                      ),

                //
              ],
            ),
          );
        },
      ),
    );
  }
}
