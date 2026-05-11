import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:protofilio/Features/Home/components/home_controller.dart';
import 'package:protofilio/Models/task_model.dart';
import 'package:protofilio/core/components/showmodelbuttomsheet.dart';
import 'package:protofilio/core/constants/storge_key.dart';
import 'package:protofilio/theme/colors.dart';
import 'package:protofilio/core/enumes/popmenueenumactions.dart';
import 'package:protofilio/core/services/perfrence_manager.dart';

import 'package:provider/provider.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    // required this.taskTitle,
    // required this.taskDesc,
    // required this.isdone,
    required this.onToggel,
    required this.model,
    required this.onDelete,
    required this.onEdite,
  });
  // final String taskTitle;
  // final String taskDesc;
  //
  final void Function(bool?) onToggel;
  final void Function(int? id) onDelete;
  final void Function() onEdite;
  final TaskModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: BoxBorder.all(
          color: Theme.of(context).colorScheme.outline,
          width: 0.5,
          style: BorderStyle.solid,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 8),
        leading: Checkbox(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(4),
          ),
          activeColor: AppColor.primaryColor,

          value: model.iSDONE,
          onChanged: (val) => onToggel(val),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        title: Text(
          model.taskName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextTheme.of(context).titleMedium?.copyWith(
            color: model.iSDONE == false ? null : AppColor.tertiarytext,
            decoration: model.iSDONE == true
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),

          /*GoogleFonts.poppins(
                  color: isdone == false ? Color(0xffFFFCFC) : Color(0xffA0A0A0),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  decorationThickness: 1.5,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationColor: Color(0xffA0A0A0),
                  decoration: isdone == true
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),*/
        ),
        subtitle: Text(
          overflow: TextOverflow.ellipsis,
          model.taskDesc,
          maxLines: 1,
          style: TextTheme.of(context).bodyMedium?.copyWith(
            color: model.iSDONE == false ? null : AppColor.tertiarytext,
            decoration: model.iSDONE == true
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),

        // بارامتر رابع مفيد جداً للوصف
        trailing: PopupMenuButton<Popmenueenumactions>(
          icon: Icon(
            Icons.more_vert,
            size: 20,
            color: model.iSDONE == false ? null : AppColor.tertiarytext,
          ),
          onSelected: (action) async {
            switch (action) {
              case Popmenueenumactions.start:
                {
                  print('h');
                }
              case Popmenueenumactions.markAsDone:
                {
                  onToggel(!model.iSDONE);
                }
              case Popmenueenumactions.edite:
                {
                  final result = await showmodelbuttomsheet(context, model);
                  if (result == true) {
                    onEdite();
                  } else {}
                }
              case Popmenueenumactions.delete:
                {
                  showadilog(context, onDelete, model);
                }
            }
          },
          itemBuilder: (context) => Popmenueenumactions.values.map((e) {
            final color = e == Popmenueenumactions.delete
                ? Colors.red
                : (e == Popmenueenumactions.edite
                      ? null
                      : AppColor.primaryColor);
            return PopupMenuItem<Popmenueenumactions>(
              value: Popmenueenumactions.values[e.index],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Popmenueenumactions.values[e.index].icon, color: color),
                  Text(
                    Popmenueenumactions.values[e.index].name,
                    style: TextStyle(color: color),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

showadilog(
  BuildContext context,
  final void Function(int? id) onDelete,
  TaskModel model,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Delete Task'),

        content: Text('Are You Sure To Delete This TAsk'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onDelete(model.id);
              Navigator.pop(context);
            },
            style: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(Colors.red),
            ),
            child: Text('Delete'),
          ),
        ],
      );
    },
  );
}
