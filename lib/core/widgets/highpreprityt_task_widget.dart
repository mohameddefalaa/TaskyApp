import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protofilio/Models/task_model.dart';
import 'package:protofilio/Shared/colors.dart';
import 'package:protofilio/core/services/perfrence_manager.dart';
import 'package:protofilio/core/widgets/task_check_list.dart';

class HighPeriorityTask extends StatefulWidget {
  const HighPeriorityTask({
    super.key,
    required this.highPriorityTasksList,
    // required this.compleatedtasks,
    required this.percent,
    required this.onDelete,
  });
  final List<TaskModel> highPriorityTasksList;
  final void Function() percent;
  final void Function(int id) onDelete;

  @override
  State<HighPeriorityTask> createState() => _HighPeriorityTaskState();
}

class _HighPeriorityTaskState extends State<HighPeriorityTask> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline, // سحب اللون من الثيم
          width: 1.0, // سمك الخط
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
                widget.highPriorityTasksList.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final highPreorityTask =
                              widget.highPriorityTasksList[index];
                          return ChckListTask(
                            onDelete: widget.onDelete,
                            isdone: highPreorityTask.iSDONE,
                            onchange: (value) async {
                              setState(() {
                                highPreorityTask.iSDONE = value ?? false;
                              });
                              widget.percent();
                            },
                            desc: highPreorityTask.taskDesc,
                            taskname: highPreorityTask.taskName,
                            perority: highPreorityTask.isHighpreority,
                          );
                        },

                        itemCount: widget.highPriorityTasksList.length > 4
                            ? 4
                            : widget.highPriorityTasksList.length,
                      )
                    : Text(
                        'No Tasks Yet',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
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
                width: 1.25,
              ),
            ),
            clipBehavior:
                Clip.hardEdge, // لضمان عدم خروج التموج عن حدود الدائرة
            child: InkWell(
              onTap: () {},
              // لون التموج الأخضر الشفاف من الثيم
              splashColor: AppColor.primaryColor.withAlpha(20),
              child: const Padding(
                padding: EdgeInsets.all(12.0), // مساحة الضغط
                child: Icon(Icons.north_east_rounded, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
