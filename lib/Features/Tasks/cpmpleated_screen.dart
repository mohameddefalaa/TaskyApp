import 'package:flutter/material.dart';
import 'package:protofilio/Features/Tasks/tasks_controller.dart';

import 'package:protofilio/core/components/task_item.dart';
import 'package:provider/provider.dart';

class CompleatedScreen extends StatelessWidget {
  const CompleatedScreen({super.key});

  // Future<void> loadtasks() async {
  //   // final pref = await SharedPreferences.getInstance();
  //   final String? tasks = PerfrenceManager().getstring(StorgeKey.tasksdata);
  //   if (tasks != null) {
  //     List<dynamic> tasksDecode = jsonDecode(tasks);
  //     final alltasksdecode = tasksDecode
  //         .map((e) => TaskModel.fromjson(e))
  //         .toList();
  //     setState(() {
  //       compleatedTaska = alltasksdecode
  //           .where((e) => e.iSDONE == true)
  //           .toList();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TasksController>(
      create: (BuildContext context) {
        return TasksController()..init();
      },
      builder: (context, child) {
        final controller = context.watch<TasksController>();
        return CustomScrollView(
          slivers: [
            SliverAppBar(title: Text('Compleated Tasks')),
            SliverList.builder(
              itemCount: controller.compleatedTasksListdata.length,

              itemBuilder: (context, index) {
                final complettask = controller.compleatedTasksListdata[index];

                return TaskItem(
                  model: complettask,
                  onToggel: (bool? status) {
                    controller.toggleTaskStatus(complettask, status!);
                  },
                  onDelete: (int? id) {
                    controller.deleteTask(complettask.id);
                  },
                  onEdite: () {
                    controller.refreshTasks();
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
