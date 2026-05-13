import 'package:flutter/material.dart';
import 'package:protofilio/Features/Tasks/tasks_controller.dart';
import 'package:protofilio/core/components/task_item.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TasksController>();
    return CustomScrollView(
      slivers: [
        SliverAppBar(title: Text("Todo Tasks")),
        controller.todoTasksListdata.isNotEmpty
            ? SliverList.builder(
                itemCount: controller.todoTasksListdata.length,

                itemBuilder: (context, index) {
                  final noDonetask = controller.todoTasksListdata[index];

                  return TaskItem(
                    model: noDonetask,
                    onToggel: (bool? val) {
                      controller.toggleTaskStatus(noDonetask, val!);
                    },
                    onDelete: (int? id) {
                      controller.deleteTask(noDonetask.id);
                    },
                    onEdite: () {
                      controller.refreshTasks();
                    },
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
      //                 final data = pref.getString(StorgeKey.tasksdata);
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
      //                       StorgeKey.tasksdata,
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
