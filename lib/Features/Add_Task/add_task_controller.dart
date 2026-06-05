import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:protofilio/Models/task_model.dart';
import 'package:protofilio/core/services/file_storage_manger.dart';

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
      final List<TaskModel> taskslist = HiveStorageManger().loadData();

      TaskModel model = TaskModel(
        id: taskslist.length + 1,
        taskName: nameController.value.text,
        isHighpreority: ishighpreority,
        taskDesc: descController.value.text,
        taskTime: selectedtime,
        taskDate: selectedDate,
      );
      taskslist.add(model);

      await HiveStorageManger().saveTasks(taskslist);

      Navigator.of(context).pop(true);
      notifyListeners();
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
