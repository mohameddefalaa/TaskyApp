import 'package:flutter/material.dart';

class TaskModel {
  int id;
  String taskName;
  String taskDesc;
  bool isHighpreority;
  bool iSDONE;
  DateTime taskDate;
  TimeOfDay taskTime;
  TaskModel({
    required this.id,
    required this.taskTime,
    required this.taskDate,
    required this.taskName,
    required this.isHighpreority,
    required this.taskDesc,
    this.iSDONE = false,
  });
  // convert model into jsondata
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "taskName": taskName,
      'taskDes': taskDesc,
      'highpriority': isHighpreority,
      'iSDONE': iSDONE,
      'taskDate': taskDate.toIso8601String(),
      'taskHour': taskTime.hour,
      'taskMinute': taskTime.minute,
    };
  }

  /// convert fromjson into model
  factory TaskModel.fromjson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] ?? 0,
      taskName: json['taskName'] ?? "",
      isHighpreority: json['highpriority'] ?? false,
      taskDesc: json['taskDes'] ?? "",
      iSDONE: json['iSDONE'] ?? false,
      taskTime:
          json['taskHour'] ==
              null // انا اختبرت قيمة واحد فقط عاشان انا ببعتهم مع بعض وبرجعهم مع بعض ف لو وحده جت التالنية اكيد تمم
          ? TimeOfDay.now()
          : TimeOfDay(hour: json['taskHour'], minute: json['taskMinute']),
      taskDate: json['taskDate'] == null
          ? DateTime.now()
          : DateTime.parse(json['taskDate']),
    );
  }
}
