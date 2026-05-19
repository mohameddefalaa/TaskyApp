import 'package:flutter/material.dart';
import 'package:protofilio/Features/Tasks/tasks_controller.dart';
import 'package:protofilio/core/constants/app_size.dart';

import 'package:protofilio/core/components/task_item.dart';
import 'package:provider/provider.dart';

class CompleatedScreen extends StatelessWidget {
  const CompleatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TasksController>();

    return CustomScrollView(
      slivers: [
        SliverAppBar(title: const Text('Compleated Tasks')),
        SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.dg16,
            vertical: AppSize.dg8,
          ),
          sliver: SliverList.builder(
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
        ),
      ],
    );
  }
}
