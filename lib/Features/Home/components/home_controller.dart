import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:protofilio/Models/task_model.dart';
import 'package:protofilio/core/constants/storge_key.dart';
import 'package:protofilio/core/services/perfrence_manager.dart';

class HomeController with ChangeNotifier {
  List<TaskModel> allTasks = [];
  String? finalname;
  String? finalbio;
  bool isDark = true;
  List<TaskModel> highPriorityTasksList = [];
  List<TaskModel> compleatedtasks = [];
  List<TaskModel> allDataTaska = [];
  File? selectedimage;

  int selescteindex = 0;
  int totalTasks = 0;
  double percent = 0;

  void init() {
    loadUsername();
    gettaskname();
    getimage();
  }

  void getimage() {
    String? imagepath = PerfrenceManager().getstring(StorgeKey.userImage);
    if (imagepath != null && imagepath.isNotEmpty && imagepath != 'null') {
      selectedimage = File(imagepath);
    } else {
      selectedimage = null;
      notifyListeners();
    }
  }

  void loadUsername() async {
    // final pref = await SharedPreferences.getInstance();
    finalname = PerfrenceManager().getstring(StorgeKey.username);
    finalbio =
        PerfrenceManager().getstring(StorgeKey.bio) ??
        "One task at a time. One step closer.";
    notifyListeners();
  }

  void calculatepercentage() async {
    totalTasks = allDataTaska.length;
    if (totalTasks == 0) {
      totalTasks = 0;
    } else {
      percent = (compleatedtasks.length / totalTasks);
    }

    final jsonUpdate = allDataTaska.map((e) => e.toJson()).toList();
    await PerfrenceManager().setstring(
      StorgeKey.tasksdata,
      jsonEncode(jsonUpdate),
    );
    notifyListeners();
  }

  Future<void> gettaskname() async {
    //final pref = await SharedPreferences.getInstance();
    final decodingTask = PerfrenceManager().getstring(StorgeKey.tasksdata);
    //final decodingTask = pref.getString("taasksData");
    if (decodingTask != null) {
      final finalDecodingTask = jsonDecode(decodingTask) as List<dynamic>;
      var allTasks = finalDecodingTask.map((toElement) {
        return TaskModel.fromjson(toElement);
      }).toList();

      allDataTaska = allTasks;
      // log("${allTasks.length}");//
      highPriorityTasksList = allDataTaska.reversed
          .where((task) => task.isHighpreority == true)
          .toList();

      compleatedtasks = allDataTaska.reversed
          .where((task) => task.iSDONE == true)
          .toList();
      calculatepercentage();
      notifyListeners();
    }
  }

  void toggleTaskStatus(TaskModel task, bool status) async {
    task.iSDONE = status;
    if (status) {
      compleatedtasks.add(task);
    } else {
      compleatedtasks.remove(task);
    }

    // اللوجيك الخاص بالحفظ والنسبة موجود بالفعل في هذه الدالة عندك
    calculatepercentage();
  }
}
