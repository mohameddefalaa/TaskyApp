import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protofilio/Features/Tasks/high_periority_tasks.dart';
import 'package:protofilio/Features/Tasks/tasks_controller.dart';
import 'package:protofilio/theme/colors.dart';
import 'package:protofilio/core/constants/app_size.dart';
import 'package:protofilio/core/components/task_check_list.dart';
import 'package:provider/provider.dart';

class HighPeriorityTask extends StatelessWidget {
  const HighPeriorityTask({
    super.key,
    // required this.highPriorityTasksList,
    // // required this.compleatedtasks,
    // required this.percent,
    // required this.onDelete,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder: (context, value, child) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.dg8,
            vertical: AppSize.dg16,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(AppSize.r16),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.outline, // سحب اللون من الثيم
              width: 1.0, // Standard border width
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "High Priority Tasks",
                      style: TextTheme.of(
                        context,
                      ).bodyMedium?.copyWith(color: AppColor.primaryColor),
                    ),
                    value.highPriorityTasksList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final highPreorityTask =
                                  value.highPriorityTasksList[index];
                              return ChckListTask(
                                onChanged: (newval) {
                                  value.toggleTaskStatus(
                                    highPreorityTask,
                                    newval!,
                                  );
                                },
                                taskname: highPreorityTask.taskName,
                                isdone: highPreorityTask.iSDONE,
                              );
                            },

                            itemCount: value.highPriorityTasksList.length > 4
                                ? 4
                                : value.highPriorityTasksList.length,
                          )
                        : Text(
                            'No Tasks Yet',
                            style: GoogleFonts.poppins(
                              fontSize: AppSize.sp14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                  ],
                ),
              ),
              Material(
                // نستخدم لون الـ surface من الثيم هنا بدلاً من الحاوية
                color: Theme.of(context).colorScheme.surface,
                shape: CircleBorder(
                  side: BorderSide(
                    color: Theme.of(
                      context,
                    ).colorScheme.outlineVariant.withAlpha(60),
                    width: AppSize.w1, // Custom border width
                  ),
                ),
                clipBehavior:
                    Clip.hardEdge, // لضمان عدم خروج التموج عن حدود الدائرة
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => HighPeriorityTasks()),
                    ).then((value) {
                      // الكود ده هيتنفذ لما ترجع من الشاشة التانية
                      context.read<TasksController>().refreshTasks();
                    });
                  },
                  // لون التموج الأخضر الشفاف من الثيم
                  splashColor: AppColor.primaryColor.withAlpha(20),
                  child: Padding(
                    padding: EdgeInsets.all(AppSize.dg12), // مساحة الضغط
                    child: Icon(Icons.north_east_rounded, size: AppSize.r20),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
