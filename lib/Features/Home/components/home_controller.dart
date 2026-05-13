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
  bool isdone = false;

  int selescteindex = 0;
  int totalTasks = 0;
  double percent = 0;

  void init() {
    getuserData();
  }

  void getuserData() {
    String? imagepath = PerfrenceManager().getstring(StorgeKey.userImage);
    if (imagepath != null && imagepath.isNotEmpty && imagepath != 'null') {
      selectedimage = File(imagepath);
    } else {
      selectedimage = null;
    }
    finalname = PerfrenceManager().getstring(StorgeKey.username);
    finalbio =
        PerfrenceManager().getstring(StorgeKey.bio) ??
        "One task at a time. One step closer.";
    notifyListeners();
  }
}
