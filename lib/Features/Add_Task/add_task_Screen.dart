import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:protofilio/Features/Add_Task/add_task_controller.dart';
import 'package:protofilio/Models/task_model.dart';
import 'package:protofilio/core/constants/storge_key.dart';
import 'package:protofilio/core/services/perfrence_manager.dart';
import 'package:protofilio/core/widgets/custome_button.dart';
import 'package:protofilio/Features/Profile/widgets/custome_card.dart';
import 'package:protofilio/core/widgets/custome_text_filed.dart';
import 'package:provider/provider.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return AddTaskController();
      },
      builder: (context, child) {
        final controller = context.read<AddTaskController>();
        return Scaffold(
          appBar: AppBar(title: Text('New Task')),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Form(
                key: controller.key,
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
                          controller: controller.nameController,

                          hinttext: 'mma trainig ',
                        ),
                        const SizedBox(height: 20),

                        CustomeTextFiled(
                          title: 'TAsk Desc',
                          maxlins: 25,
                          minlins: 4,
                          controller: controller.descController,
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
                    Consumer<AddTaskController>(
                      builder: (BuildContext context, value, Widget? child) {
                        return Row(
                          children: [
                            CustomecCard(
                              onTap: () async {
                                final selecteduserDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2028),
                                );

                                value.updateDate(selecteduserDate);
                              },
                              titleCard: 'Date',
                              title: DateFormat(
                                'EEEE',
                              ).format(value.selectedDate).toUpperCase(),

                              subTitle: DateFormat(
                                'd MMM, yyyy',
                              ).format(value.selectedDate),
                              leadingWidget: Icon(Icons.calendar_month),
                            ),
                            CustomecCard(
                              onTap: () async {
                                final selectedusertime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );

                                value.updatetime(selectedusertime);
                              },
                              titleCard: 'Time',
                              title: 'Start',
                              subTitle: DateFormat('hh:mm a').format(
                                DateTime(
                                  controller.selectedDate.year,
                                  controller.selectedDate.month,
                                  controller.selectedDate.day,
                                  controller.selectedtime.hour,
                                  controller.selectedtime.minute,
                                ),
                              ),
                              leadingWidget: Icon(Icons.alarm),
                            ),
                          ],
                        );
                      },
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
                                style: TextTheme.of(context).bodyMedium!
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Flag for immediate focus",
                                style: TextTheme.of(
                                  context,
                                ).bodyMedium!.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                          Consumer<AddTaskController>(
                            builder: (BuildContext context, value, Widget? child) {
                              return Switch(
                                splashRadius: 2,

                                value: value.ishighpreority,
                                onChanged: (action) {
                                  value.toogel(
                                    action,
                                  ); // نمرر القيمة التي جاءت من التشيك بوكس للكنترولر
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    CustomeButton(
                      icon: SvgPicture.asset('assets/images/PLUS_icon.svg'),

                      title: 'Add A New Task ',

                      onPressed: () {
                        controller.addTask(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
