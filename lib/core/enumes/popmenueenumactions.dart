import 'package:flutter/material.dart';

enum Popmenueenumactions {
  start(name: "Start To Finish", icon: Icons.low_priority),

  markAsDone(name: 'Mark As Done', icon: Icons.check_circle_outline),

  edite(name: 'Edit', icon: Icons.edit_outlined),
  delete(name: 'Delete', icon: Icons.delete_outline);

  final String name;
  const Popmenueenumactions({required this.name, required this.icon});
  final IconData icon;
}
