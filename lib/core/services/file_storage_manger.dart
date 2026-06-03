import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorageManger {
  static final FileStorageManger _instance = FileStorageManger._();

  FileStorageManger._() {}

  factory FileStorageManger() {
    return _instance;
  }
  late final appDocumentDirectory;
  late final File fileTasks;
  Future<void> init() async {
    appDocumentDirectory = await getApplicationDocumentsDirectory();
    fileTasks = File("${appDocumentDirectory.path}/tasks.json");
  }

  saveTasks(List<dynamic> list) async {
    final tasksencode = jsonEncode(list);
    await fileTasks.writeAsString(tasksencode);
  }

  Future<List<dynamic>> loadData() async {
    final tasksjson = await fileTasks.readAsString();
    return jsonDecode(tasksjson) as List<dynamic>;
  }
}
