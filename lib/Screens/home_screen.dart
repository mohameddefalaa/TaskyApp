import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protofilio/Models/task_model.dart';
import 'package:protofilio/Screens/add_task_Screen.dart';
import 'package:protofilio/core/services/perfrence_manager.dart';
import 'package:protofilio/core/widgets/archived_task_widget.dart';
import 'package:protofilio/core/widgets/custome_svg.dart';
import 'package:protofilio/core/widgets/highpreprityt_task_widget.dart';
import 'package:protofilio/core/widgets/task_item.dart';
import 'package:protofilio/theme/theme_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? finalname;
  String? finalbio;
  bool isDark = true;
  List<TaskModel> highPriorityTasksList = [];
  List<TaskModel> compleatedtasks = [];
  List<TaskModel> allDataTaska = [];
  File? selectedimage;

  int selescteindex = 0;
  int totalTasks = 0;
  double percent = 0;

  @override
  void initState() {
    getfullname();
    gettaskname();
    getimage();

    super.initState();
  }

  Future<void> gettaskname() async {
    //final pref = await SharedPreferences.getInstance();
    final decodingTask = PerfrenceManager().getstring('taasksData');
    //final decodingTask = pref.getString("taasksData");
    if (decodingTask != null) {
      final finalDecodingTask = jsonDecode(decodingTask) as List<dynamic>;
      var allTasks = finalDecodingTask.map((toElement) {
        return TaskModel.fromjson(toElement);
      }).toList();
      setState(() {
        allDataTaska = allTasks;
        log("${allTasks.length}");
        highPriorityTasksList = allDataTaska.reversed
            .where((task) => task.isHighpreority == true)
            .toList();

        compleatedtasks = allDataTaska.reversed
            .where((task) => task.iSDONE == true)
            .toList();
        calculatepercentage();
      });
    }
  }

  void calculatepercentage() async {
    setState(() {
      totalTasks = allDataTaska.length;
      if (totalTasks == 0) {
        totalTasks = 0;
      } else {
        percent = (compleatedtasks.length / totalTasks);
      }
    });
    final jsonUpdate = allDataTaska.map((e) => e.toJson()).toList();
    await PerfrenceManager().setstring('taasksData', jsonEncode(jsonUpdate));
  }

  @override
  Widget build(BuildContext context) {
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

              gettaskname();
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipOval(
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(35),
                                child:
                                    selectedimage != null &&
                                        selectedimage!.existsSync()
                                    ? Image.file(selectedimage!)
                                    : SvgPicture.asset(
                                        "assets/images/person.svg",
                                        alignment: AlignmentGeometry.center,
                                        fit: BoxFit.cover,

                                        height: 50,
                                        width: 50,
                                      ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    "Good Evening, ${finalname?.split(' ').first ?? ''}", //تم تحويل الاسمك الي ليست اوف كلمات وبالتالي طلبنا منه الكلمة الاولي
                                    style: TextTheme.of(context).titleMedium,
                                  ),
                                  Text(
                                    overflow: TextOverflow.clip,
                                    finalbio ??
                                        'One task at a time. One step closer.',
                                    style: TextTheme.of(context).bodyMedium,
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
                          compleatedtasks: compleatedtasks,
                          totalTasks: totalTasks,
                          percent: percent,
                          alltasks: allDataTaska,
                          highPriorityTasksList: allDataTaska,
                        ),
                        const SizedBox(height: 8),
                        HighPeriorityTask(
                          onDelete: (id) async {
                            highPriorityTasksList.removeWhere(
                              (e) => e.id == id,
                            );
                            final allData = PerfrenceManager().getstring(
                              'taasksData',
                            );
                            if (allData != null) {
                              final alljsondata =
                                  jsonDecode(allData) as List<dynamic>;
                              List<TaskModel> highPreiortyTaskslIST =
                                  alljsondata
                                      .map((e) => TaskModel.fromjson(e))
                                      .toList();
                              setState(() {
                                highPreiortyTaskslIST.removeWhere(
                                  (element) => element.id == id,
                                );
                              });

                              await PerfrenceManager().setstring(
                                'taasksData',
                                jsonEncode(highPreiortyTaskslIST),
                              );
                            }
                          },
                          percent: calculatepercentage,
                          highPriorityTasksList: allDataTaska
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
          allDataTaska.isNotEmpty
              ? SliverPadding(
                  padding: EdgeInsetsGeometry.only(bottom: 75),
                  sliver: SliverList.builder(
                    itemCount: allDataTaska.length,
                    itemBuilder: (context, index) {
                      final normaltasks = allDataTaska[index];
                      return TaskItem(
                        onEdite: () {
                          setState(() {
                            gettaskname();
                          });
                        },
                        model: normaltasks,
                        onDelete: (id) async {
                          allDataTaska.removeWhere((task) => task.id == id);
                          List<TaskModel> alltasks = [];
                          alltasks.addAll(allDataTaska);
                          final jsonupdate = alltasks
                              .map((elemnt) => elemnt.toJson())
                              .toList();
                          await PerfrenceManager().setstring(
                            'taasksData',
                            jsonEncode(jsonupdate),
                          );
                          setState(() {
                            calculatepercentage();
                          });
                        },
                        onchange: (value) async {
                          setState(() {
                            normaltasks.iSDONE = value ?? false;
                            normaltasks.iSDONE
                                ? compleatedtasks.add(normaltasks)
                                : compleatedtasks.remove(normaltasks);
                            calculatepercentage();
                          });

                          List<TaskModel> alltasks = [];
                          alltasks.addAll(allDataTaska);
                          final jsonupdate = alltasks
                              .map((elemnt) => elemnt.toJson())
                              .toList();

                          await PerfrenceManager().setstring(
                            'taasksData',
                            jsonEncode(jsonupdate),
                          );
                        },
                        isdone: normaltasks.iSDONE,
                        taskTitle: normaltasks.taskName,
                        taskDesc: normaltasks.taskDesc,
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
  }

  void getfullname() async {
    // final pref = await SharedPreferences.getInstance();
    finalname = PerfrenceManager().getstring('Full Name');
    finalbio =
        PerfrenceManager().getstring('bio') ??
        "One task at a time. One step closer.";

    setState(() {});
  }

  void getimage() {
    setState(() {
      String? imagepath = PerfrenceManager().getstring('image');
      if (imagepath != null && imagepath.isNotEmpty && imagepath != 'null') {
        selectedimage = File(imagepath);
      } else {
        selectedimage = null;
      }
    });
  }
}
