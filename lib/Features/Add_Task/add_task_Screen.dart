import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:protofilio/Models/task_model.dart';
import 'package:protofilio/Shared/colors.dart';
import 'package:protofilio/core/services/perfrence_manager.dart';
import 'package:protofilio/core/widgets/custome_button.dart';
import 'package:protofilio/core/widgets/custome_card.dart';
import 'package:protofilio/core/widgets/custome_text_filed.dart';
import 'package:protofilio/theme/dark_theme.dart';

class AddTask extends StatefulWidget {
  const AddTask(this.isedite, {super.key});

  @override
  State<AddTask> createState() => _AddTaskState();

  final bool? isedite;
}

class _AddTaskState extends State<AddTask> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  bool ishighpreority = false;
  late DateTime selectedDate;
  late TimeOfDay selectedtime;

  @override
  void initState() {
    selectedDate = DateTime.now();
    selectedtime = TimeOfDay.now();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Task')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: key,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomeTextFiled(
                      title: 'Task Name',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "please enter task name";
                        } else {
                          return null;
                        }
                      },
                      maxlins: 1,
                      minlins: 1,
                      controller: nameController,

                      hinttext: 'mma trainig ',
                    ),
                    const SizedBox(height: 20),

                    CustomeTextFiled(
                      title: 'TAsk Desc',
                      maxlins: 25,
                      minlins: 4,
                      controller: descController,
                      hinttext:
                          ' It looks like your previous text wasn’t readable —',
                    ),
                    const SizedBox(height: 20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       "High Priority",
                    //       style: TextTheme.of(context).titleMedium,
                    //     ),
                    //     SizedBox(
                    //       height: 32,
                    //       width: 52,
                    //       child: Switch(
                    //         splashRadius: 2,

                    //         value: ishighpreority,
                    //         onChanged: (bool value) {
                    //           setState(() {
                    //             ishighpreority = value;
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
                Row(
                  children: [
                    CustomecCard(
                      onTap: () async {
                        final selecteduserDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2028),
                        );
                        setState(() {
                          selecteduserDate == null
                              ? selectedDate = DateTime.now()
                              : selectedDate = selecteduserDate;
                        });
                      },
                      titleCard: 'Date',
                      title: DateFormat(
                        'EEEE',
                      ).format(selectedDate).toUpperCase(),

                      subTitle: DateFormat('d MMM, yyyy').format(selectedDate),
                      leadingWidget: Icon(Icons.calendar_month),
                    ),
                    CustomecCard(
                      onTap: () async {
                        final selectedusertime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        setState(() {
                          selectedusertime == null
                              ? selectedtime = TimeOfDay.now()
                              : selectedtime = selectedusertime;
                        });
                      },
                      titleCard: 'Time',
                      title: 'Start',
                      subTitle: DateFormat('hh:mm a').format(
                        DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedtime.hour,
                          selectedtime.minute,
                        ),
                      ),
                      leadingWidget: Icon(Icons.alarm),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  padding: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.all(8),
                        height: MediaQuery.of(context).size.height * 00.07,
                        width: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                          color: Color(0xffFEE2E1),

                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.electric_bolt_outlined,
                          color: Color(0xffBD1622),
                          size: 30,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "High Priority",
                            style: TextTheme.of(
                              context,
                            ).bodyMedium!.copyWith(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Flag for immediate focus",
                            style: TextTheme.of(
                              context,
                            ).bodyMedium!.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                      Switch(
                        splashRadius: 2,

                        value: ishighpreority,
                        onChanged: (bool value) {
                          setState(() {
                            ishighpreority = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                CustomeButton(
                  icon: SvgPicture.asset('assets/images/PLUS_icon.svg'),

                  title: 'Add A New Task ',

                  onPressed: () async {
                    if (key.currentState?.validate() ?? false) {
                      //    final pref = await SharedPreferences.getInstance();
                      final jsonlist = PerfrenceManager().getstring(
                        'taasksData',
                      );
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

                      await PerfrenceManager()
                          .setstring("taasksData", taasksData)
                          .then((value) {
                            Navigator.of(context).pop(true);
                          });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
