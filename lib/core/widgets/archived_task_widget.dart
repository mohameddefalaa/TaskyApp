import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:protofilio/Models/task_model.dart';
import 'package:protofilio/Shared/colors.dart';

class ArchivedTask extends StatelessWidget {
  const ArchivedTask({
    super.key,
    required this.compleatedtasks,
    required this.totalTasks,
    required this.percent,
    required this.alltasks,
    required this.highPriorityTasksList,
  });

  final List<TaskModel> compleatedtasks;
  final int totalTasks;
  final double percent;
  final List<TaskModel> alltasks;
  final List<TaskModel> highPriorityTasksList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      width: double.infinity,
      height: 72,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  overflow: TextOverflow.clip,
                  "Achieved Tasks",
                  style: TextTheme.of(context).titleMedium,
                ),
                Text(
                  overflow: TextOverflow.clip,
                  "${compleatedtasks.length} out of ${totalTasks} Done",
                  style: TextTheme.of(context).bodyMedium,
                ),
              ],
            ),
            percent * 100 == 100
                ? SvgPicture.asset(
                    "assets/images/done2.svg",
                    height: 50,
                    width: 50,
                    color: AppColor.primaryColor,
                  )
                : SizedBox(),

            CircularPercentIndicator(
              backgroundColor: Color(0XFF9E9E9E),
              startAngle: 270.0,
              percent: percent,
              radius: 26,
              progressColor: AppColor.primaryColor,
              center: Text(
                (alltasks.isEmpty && highPriorityTasksList.isEmpty)
                    ? "0%" //to avoid null value when the taskslist is empty.
                    : "${(percent * 100).toInt()}%",
                textAlign: TextAlign.center,
                style: TextTheme.of(context).bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
