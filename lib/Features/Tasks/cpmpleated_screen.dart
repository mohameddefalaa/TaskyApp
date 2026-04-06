import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:protofilio/Models/task_model.dart';
import 'package:protofilio/core/services/perfrence_manager.dart';
import 'package:protofilio/core/widgets/custome_app_bar.dart';
import 'package:protofilio/core/widgets/task_check_list.dart';
import 'package:protofilio/core/widgets/task_item.dart';

class CompleatedScreen extends StatefulWidget {
  const CompleatedScreen({super.key});

  @override
  State<CompleatedScreen> createState() => _CompleatedScreenState();
}

class _CompleatedScreenState extends State<CompleatedScreen> {
  List<TaskModel> compleatedTaska = [];
  @override
  void initState() {
    super.initState();

    loadtasks();
  }

  Future<void> loadtasks() async {
    // final pref = await SharedPreferences.getInstance();
    final String? tasks = PerfrenceManager().getstring('taasksData');
    if (tasks != null) {
      List<dynamic> tasksDecode = jsonDecode(tasks);
      final alltasksdecode = tasksDecode
          .map((e) => TaskModel.fromjson(e))
          .toList();
      setState(() {
        compleatedTaska = alltasksdecode
            .where((e) => e.iSDONE == true)
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomeSliverAppBar(appBarTitle: 'Compleated Tasks'),
        SliverList.builder(
          itemCount: compleatedTaska.length,

          itemBuilder: (context, index) {
            final complettask = compleatedTaska[index];

            return TaskItem(
              onEdite: () {
                loadtasks();
              },
              onDelete: (id) async {
                compleatedTaska.removeWhere((task) => task.id == id);
                final alldata = PerfrenceManager().getstring('taasksData');
                if (alldata != null) {
                  final alljsondata = jsonDecode(alldata) as List<dynamic>;
                  final List<dynamic> completeTasksList = alljsondata
                      .map((e) => TaskModel.fromjson(e))
                      .toList();
                  completeTasksList.removeWhere((e) => e.id == id);

                  await PerfrenceManager().setstring(
                    'taasksData',
                    jsonEncode(completeTasksList),
                  );
                  loadtasks();
                }
              },
              model: complettask,
              taskTitle: complettask.taskName,
              taskDesc: complettask.taskDesc,
              isdone: complettask.iSDONE,
              onchange: (value) async {
                setState(() {
                  complettask.iSDONE = value ?? false;
                });
                //     final pref =
                // await SharedPreferences.getInstance(); //هات نسخة من الشيرد
                final String? allEncodeDdata = PerfrenceManager().getstring(
                  'taasksData',
                ); // هات كل التاسكات المسجلة
                if (allEncodeDdata != null) {
                  // بنتأكد ان القيمة مش فاضية
                  final List<dynamic> allJsonDecode = jsonDecode(
                    allEncodeDdata,
                  ); //فك التشفير
                  final List<dynamic> allTasks =
                      allJsonDecode // حول الجيسون الي مودل الخاص بيا
                          .map((e) => TaskModel.fromjson(e))
                          .toList();
                  int currentindex = allTasks.indexWhere(
                    // بتعرف علي مكان التاسك الحالي اللي انا هلغي كونه اكتمل ام لا في الداتا الكاملة
                    (e) => e.id == complettask.id,
                  );
                  if (currentindex != -1) {
                    // بـتأكد ان الاندكس صحيح من خلال ال id
                    allTasks[currentindex].iSDONE = complettask
                        .iSDONE; // بغير قيمة التاسك في القايمة الكبيرة اللي بتشمل كل التاسكات االلي عغندي
                    final jsonUpdate = allTasks
                        .map((e) => e.toMap())
                        .toList(); //بشفر القايمة بعد التحخديث
                    await PerfrenceManager().setstring(
                      'taasksData',
                      jsonEncode(jsonUpdate),
                    ); // بخزن القيمة المشفرة في الشيرد 1
                    loadtasks(); // بستدعي القايمة بعد  التحخديث
                  }
                }
              },
            );
          },
        ),
      ],
    );
  }
}
