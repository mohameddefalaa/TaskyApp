import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protofilio/Models/task_model.dart';
import 'package:protofilio/Shared/colors.dart';
import 'package:protofilio/core/services/perfrence_manager.dart';
import 'package:protofilio/core/widgets/task_check_list.dart';
import 'package:protofilio/core/widgets/task_item.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key /*required this.Todo*/});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<TaskModel> highPriorityTasksList = [];
  List<TaskModel> normalTasksList = [];
  List<TaskModel> newTodoList = [];
  @override
  void initState() {
    gettaskname();

    super.initState();
  }

  Future<void> gettaskname() async {
    //final pref = await SharedPreferences.getInstance();
    final decodingTask = PerfrenceManager().getstring("taasksData");
    if (decodingTask != null) {
      final finalDecodingTask = jsonDecode(decodingTask) as List<dynamic>;
      var allTasks = finalDecodingTask.map((toElement) {
        return TaskModel.fromjson(toElement);
      }).toList();
      setState(() {
        newTodoList = allTasks
            .where((elemnt) => elemnt.iSDONE == false)
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(title: Text("Todo Tasks")),
        newTodoList.isNotEmpty
            ? SliverList.builder(
                itemCount: newTodoList.length,

                itemBuilder: (context, index) {
                  final noDonetask = newTodoList[index];

                  return TaskItem(
                    onEdite: () {
                      gettaskname();
                    },
                    model: noDonetask,
                    onDelete: (id) async {
                      final alldata = PerfrenceManager().getstring(
                        'taasksData',
                      );
                      if (alldata != null) {
                        final data = jsonDecode(alldata) as List<dynamic>;
                        final List<TaskModel> allTasksList = data
                            .map((task) => TaskModel.fromjson(task))
                            .toList();
                        allTasksList.removeWhere((task) => task.id == id);

                        final updeatedData = allTasksList
                            .map((e) => e.toJson())
                            .toList();
                        await PerfrenceManager().setstring(
                          'taasksData',
                          jsonEncode(updeatedData),
                        );
                        gettaskname();
                      }
                    },
                    isdone: noDonetask.iSDONE,
                    onchange: (value) async {
                      setState(() {
                        noDonetask.iSDONE = value ?? false;
                      });
                      //       final pref = await SharedPreferences.getInstance();
                      final data = PerfrenceManager().getstring('taasksData');
                      if (data != null) {
                        final alljson = jsonDecode(data) as List<dynamic>;
                        List<dynamic> allTasks = alljson
                            .map((e) => TaskModel.fromjson(e))
                            .toList();
                        int currentindex = allTasks.indexWhere(
                          (task) => task.id == noDonetask.id,
                        );
                        if (currentindex != -1) {
                          allTasks[currentindex].iSDONE = noDonetask.iSDONE;

                          final jsonUpdate = allTasks
                              .map((e) => e.toMap())
                              .toList();
                          await PerfrenceManager().setstring(
                            'taasksData',
                            jsonEncode(jsonUpdate),
                          );

                          gettaskname();
                        }
                      }
                    },
                    taskDesc: noDonetask.taskDesc,
                    taskTitle: noDonetask.taskName,
                  );
                },
              )
            : SliverFillRemaining(
                // تم التعديل هنا
                hasScrollBody:
                    false, // لضمان عدم حدوث مشاكل في التمرير إذا كان المحتوى صغيراً
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'No Tasks or maybe You have finished it',
                      textAlign: TextAlign
                          .center, // لضمان توسيط الأسطر إذا كان النص طويلاً
                      style: TextTheme.of(context).titleLarge,
                    ),
                  ),
                ),
              ),
      ],

      //  Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: ListView.builder(
      //           itemBuilder: (context, index) {
      //             final noDonetask = newTodoList[index];

      //             return TaskItem(
      //               isdone: noDonetask.iSDONE,
      //               onchange: (value) async {
      //                 setState(() {
      //                   noDonetask.iSDONE = value ?? false;
      //                 });
      //                 final pref = await SharedPreferences.getInstance();
      //                 final data = pref.getString('taasksData');
      //                 if (data != null) {
      //                   final alljson = jsonDecode(data) as List<dynamic>;
      //                   List<dynamic> allTasks = alljson
      //                       .map((e) => TaskModel.fromjson(e))
      //                       .toList();
      //                   int currentindex = allTasks.indexWhere(
      //                     (task) => task.id == noDonetask.id,
      //                   );
      //                   if (currentindex != -1) {
      //                     allTasks[currentindex].iSDONE = noDonetask.iSDONE;

      //                     final jsonUpdate = allTasks
      //                         .map((e) => e.toMap())
      //                         .toList();
      //                     await pref.setString(
      //                       'taasksData',
      //                       jsonEncode(jsonUpdate),
      //                     );

      //                     gettaskname();
      //                   }
      //                 }
      //               },
      //               taskDesc: noDonetask.taskDesc,
      //               taskTitle: noDonetask.taskName,
      //             );
      //           },

      //           itemCount: newTodoList.length,
      //         ),
      //       ),
      //     ],
      //   ),
    );
  }
}
