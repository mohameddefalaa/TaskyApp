import 'package:flutter/material.dart';

class CustomeSliverAppBar extends StatelessWidget {
  const CustomeSliverAppBar({super.key, required this.appBarTitle});
  final String appBarTitle;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(pinned: true, title: Text(appBarTitle));
  }
}
