import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:protofilio/Models/task_model.dart';
import 'package:protofilio/Shared/colors.dart';
import 'package:protofilio/core/enumes/popmenueenumactions.dart';
import 'package:protofilio/core/services/perfrence_manager.dart';
import 'package:protofilio/core/widgets/custome_button.dart';
import 'package:protofilio/core/widgets/custome_text_filed.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.taskTitle,
    required this.taskDesc,
    required this.isdone,
    required this.onchange,
    required this.model,
    required this.onDelete,
    required this.onEdite,
  });
  final String taskTitle;
  final String taskDesc;
  final bool isdone;
  final void Function(bool?) onchange;
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

          value: isdone,

          onChanged: onchange,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        title: Text(
          taskTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextTheme.of(context).titleMedium?.copyWith(
            color: isdone == false ? null : AppColor.tertiarytext,
            decoration: isdone == true
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
          taskDesc,
          maxLines: 1,
          style: TextTheme.of(context).bodyMedium?.copyWith(
            color: isdone == false ? null : AppColor.tertiarytext,
            decoration: isdone == true
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),

        // بارامتر رابع مفيد جداً للوصف
        trailing: PopupMenuButton<Popmenueenumactions>(
          icon: Icon(
            Icons.more_vert,
            size: 20,
            color: isdone == false ? null : AppColor.tertiarytext,
          ),
          onSelected: (value) async {
            switch (value) {
              case Popmenueenumactions.start:
                {
                  print('h');
                }
              case Popmenueenumactions.markAsDone:
                {
                  onchange(!isdone);
                }
              case Popmenueenumactions.edite:
                {
                  final result = await _showmodelbuttomsheet(context, model);
                  if (result == true) {
                    onEdite();
                  } else {}
                }
              case Popmenueenumactions.delete:
                {
                  _showadilog(context);
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

  _showadilog(BuildContext context) {
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

  Future<bool?> _showmodelbuttomsheet(BuildContext context, TaskModel model) {
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController(
      text: model.taskName,
    );
    final TextEditingController descController = TextEditingController(
      text: model.taskDesc,
    );
    bool isHighpreority = model.isHighpreority;
    return showModalBottomSheet<bool>(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Form(
                key: key,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomeTextFiled(
                            title: 'Task Name',
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "please enter  the new task name";
                              } else {
                                return null;
                              }
                            },
                            maxlins: 1,
                            minlins: 1,
                            controller: nameController,

                            hinttext: 'mma trainig ',
                          ),
                          const SizedBox(height: 20),

                          CustomeTextFiled(
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "please enter  the new task desc";
                              } else {
                                return null;
                              }
                            },
                            title: 'TAsk Desc',
                            maxlins: 60,
                            minlins: 5,
                            controller: descController,
                            hinttext:
                                ' It looks like your previous text wasn’t readable —',
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "High Priority",
                                style: TextTheme.of(context).titleMedium,
                              ),
                              SizedBox(
                                height: 32,
                                width: 52,
                                child: Switch(
                                  splashRadius: 2,

                                  value: isHighpreority,
                                  onChanged: (bool value) {
                                    setState(() {
                                      isHighpreority = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    CustomeButton(
                      icon: Icon(Icons.edit),

                      title: 'Edite The Task ',

                      onPressed: () async {
                        if (key.currentState?.validate() ?? false) {
                          //    final pref = await SharedPreferences.getInstance();
                          final jsonlist = PerfrenceManager().getstring(
                            'taasksData',
                          );
                          List<dynamic> taskslist = [];
                          if (jsonlist != null) {
                            taskslist = jsonDecode(jsonlist);
                          }
                          TaskModel newModel = TaskModel(
                            id: model.id,
                            taskName: nameController.value.text,
                            isHighpreority: isHighpreority,
                            taskDesc: descController.value.text,
                            taskTime: TimeOfDay.now(),
                            taskDate: DateTime.now(),
                          );
                          final item = taskslist.firstWhere(
                            (e) => e['id'] == model.id,
                          );
                          final int index = taskslist.indexOf(item);
                          taskslist[index] = newModel.toJson();

                          final dynamic taasksData = jsonEncode(taskslist);

                          await PerfrenceManager().setstring(
                            "taasksData",
                            taasksData,
                          );
                          if (context.mounted) {
                            Navigator.pop(context, true);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
