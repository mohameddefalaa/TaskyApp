import 'package:flutter/material.dart';
import 'package:protofilio/Features/Home/components/custome_svg.dart';
import 'package:protofilio/Features/Tasks/tasks_controller.dart';
import 'package:protofilio/core/components/task_item.dart';
import 'package:protofilio/core/constants/app_size.dart';
import 'package:provider/provider.dart';

class AllTasksListWidget extends StatelessWidget {
  const AllTasksListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder: (context, value, child) {
        return value.tasksList.isNotEmpty
            ? SliverPadding(
                padding: EdgeInsets.only(bottom: AppSize.h40 * 1.875),
                sliver: SliverList.builder(
                  itemCount: value.tasksList.length,
                  itemBuilder: (context, index) {
                    final normaltasks = value.tasksList[index];
                    return TaskItem(
                      model: normaltasks,
                      onToggel: (bool? val) {
                        value.toggleTaskStatus(normaltasks, val!);
                      },
                      onDelete: (int? id) {
                        value.deleteTask(normaltasks.id);
                      },
                      onEdite: () {
                        value.refreshTasks();
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
                        height: AppSize.h20 * 5,
                      ),
                    ),
                    SizedBox(height: AppSize.h8),
                    Text(
                      "Please Add A new Task Now Let's Go",
                      style: TextTheme.of(context).labelLarge,
                    ),
                  ],
                ),
              );

        //
      },
    );
  }
}


/* onchange: (val) {
                        value.toggleTaskStatus(normaltasks, val ?? false);
                      },
                      onEdite: () {
                        value.gettaskname();
                      },
                      onDelete: (id) async {
                        value.allDataTaska.removeWhere((task) => task.id == id);
                        List<TaskModel> alltasks = [];
                        alltasks.addAll(value.allDataTaska);
                        final jsonupdate = alltasks
                            .map((elemnt) => elemnt.toJson())
                            .toList();
                        await PerfrenceManager().setstring(
                          StorgeKey.tasksdata,
                          jsonEncode(jsonupdate),
                        );

                        value.calculatepercentage();
                      },
                    );*/