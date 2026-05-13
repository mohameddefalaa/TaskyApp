import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:protofilio/Models/task_model.dart';
import 'package:protofilio/core/constants/storge_key.dart';
import 'package:protofilio/core/services/perfrence_manager.dart';

class AddTaskController with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  bool ishighpreority = false;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedtime = TimeOfDay.now();

  void toogel(bool value) {
    ishighpreority = value;
    notifyListeners();
  }

  void addTask(BuildContext context) async {
    if (key.currentState?.validate() ?? false) {
      //    final pref = await SharedPreferences.getInstance();
      final jsonlist = PerfrenceManager().getstring(StorgeKey.tasksdata);
      List<dynamic> taskslist = [];
      if (jsonlist != null) {
        taskslist = jsonDecode(jsonlist);
      }
      TaskModel model = TaskModel(
        id: taskslist.length + 1,
        taskName: nameController.value.text,
        isHighpreority: ishighpreority,
        taskDesc: descController.value.text,
        taskTime: selectedtime,
        taskDate: selectedDate,
      );
      taskslist.add(model.toJson());
      final dynamic taasksData = jsonEncode(taskslist);

      await PerfrenceManager().setstring(StorgeKey.tasksdata, taasksData).then((
        value,
      ) {
        Navigator.of(context).pop(true);
        notifyListeners();
      });
    }
  }

  void updateDate(DateTime? newDate) {
    if (newDate != null) {
      selectedDate = newDate;
      notifyListeners();
    }
  }

  void updatetime(TimeOfDay? newTime) {
    if (newTime != null) {
      selectedtime = newTime;
      notifyListeners();
    }
  }
}
