import 'package:hive_ce_flutter/adapters.dart';
import 'package:protofilio/Models/task_model.dart';

class HiveStorageManger {
  static final HiveStorageManger _instance = HiveStorageManger._();

  HiveStorageManger._() {}

  factory HiveStorageManger() {
    return _instance;
  }
  late Box _tasksbox;
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskModelAdapter());
    await Hive.openBox<TaskModel>("Tasks");
    _tasksbox = Hive.box<TaskModel>("Tasks");
  }

  saveTasks(List<TaskModel> list) async {
    await _tasksbox.clear(); // 👈 السطر ده إجباري طالما هتستخدم addAll
    await _tasksbox.addAll(list);
  }

  List<TaskModel> loadData() {
    return _tasksbox.values.cast<TaskModel>().toList();
  }

  clear() async {
    await _tasksbox.clear();
  }
}
