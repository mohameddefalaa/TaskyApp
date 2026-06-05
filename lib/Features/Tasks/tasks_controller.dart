import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:protofilio/Models/task_model.dart';
import 'package:protofilio/core/services/file_storage_manger.dart';

class TasksController with ChangeNotifier {
  List<TaskModel> tasksList = [];
  int selescteindex = 0;
  int totalTasks = 0;
  double percent = 0;

  void init() {
    _loadtasks();
  }

  List<TaskModel> get todoTasksListdata =>
      tasksList.where((e) => !e.iSDONE).toList();

  List<TaskModel> get compleatedTasksListdata =>
      tasksList.where((e) => e.iSDONE).toList();
  List<TaskModel> get highPriorityTasksList =>
      tasksList.where((e) => e.isHighpreority).toList();
  Future<void> _loadtasks() async {
    //final pref = await SharedPreferences.getInstance();
    //final decodingTask = pref.getString("taasksData");

    tasksList = HiveStorageManger().loadData();

    calculatepercentage();

    notifyListeners();
  }

  void toggleTaskStatus(TaskModel task, bool status) async {
    task.iSDONE = status;

    // اللوجيك الخاص بالحفظ والنسبة موجود بالفعل في هذه الدالة عندك
    await _saveTasks();
    calculatepercentage();

    notifyListeners();
  }

  void deleteTask(int id) async {
    tasksList.removeWhere((task) => task.id == id);
    _saveTasks();

    notifyListeners();
    calculatepercentage();
  }

  void refreshTasks() {
    _loadtasks(); // إعادة جلب البيانات من الـ Preference
    notifyListeners();
  }

  Future<void> _saveTasks() async {
    await HiveStorageManger().saveTasks(tasksList);
  }

  void calculatepercentage() {
    // ✅ sync, no saving
    totalTasks = tasksList.length;
    percent = totalTasks == 0 ? 0 : compleatedTasksListdata.length / totalTasks;
    notifyListeners();
  }
}
