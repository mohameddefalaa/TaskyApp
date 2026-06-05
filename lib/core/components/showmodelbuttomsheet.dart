import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:protofilio/Models/task_model.dart';
import 'package:protofilio/core/constants/storge_key.dart';
import 'package:protofilio/core/services/file_storage_manger.dart';
import 'package:protofilio/core/services/perfrence_manager.dart';
import 'package:protofilio/core/widgets/custome_button.dart';
import 'package:protofilio/core/widgets/custome_text_filed.dart';

Future<bool?> showmodelbuttomsheet(BuildContext context, TaskModel model) {
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
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 16),
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
                        List<TaskModel> taskslist = HiveStorageManger()
                            .loadData();
                        TaskModel newModel = TaskModel(
                          id: model.id,
                          taskName: nameController.value.text,
                          isHighpreority: isHighpreority,
                          taskDesc: descController.value.text,
                          taskTime: TimeOfDay.now(),
                          taskDate: DateTime.now(),
                        );
                        final int index = taskslist.indexWhere(
                          (e) => e.id == model.id,
                        );
                        if (index != -1) {
                          taskslist[index] = newModel;
                          await HiveStorageManger().saveTasks(taskslist);
                          if (context.mounted) {
                            Navigator.pop(context, true);
                          }
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
