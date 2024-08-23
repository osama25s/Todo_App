import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/App_Theme.dart';
import 'package:todo_app/firebase_service.dart';
import 'package:todo_app/models/Task_Model.dart';
import 'package:todo_app/tabs/Authentication/User_Provider.dart';
import 'package:todo_app/tabs/Tasks/default_Button.dart';
import 'package:todo_app/tabs/Tasks/default_TextFormFiled.dart';
import 'package:todo_app/tabs/Tasks/tasks_provider.dart';

class EditTask_Tab extends StatefulWidget {
  static const String routname = 'editeTask';
  EditTask_Tab({super.key});

  @override
  State<EditTask_Tab> createState() => _EditTask_TabState();
}

class _EditTask_TabState extends State<EditTask_Tab> {
  TextEditingController titleEditController = TextEditingController();

  TextEditingController decriptEditController = TextEditingController();

  DateTime selecteddate = DateTime.now();

  DateFormat formatdate = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    TaskModel argument =
        ModalRoute.of(context)!.settings.arguments as TaskModel;

    titleEditController.text = argument.title;

    decriptEditController.text = argument.description;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Container(
          width: 352.w,
          height: 617.h,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            children: [
              Text(
                'Edit Task',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppTheme.black),
              ),
              SizedBox(
                height: 55.h,
              ),
              DefaultTextFiled(
                taskController: titleEditController,
                hint: 'Task Title',
              ),
              const SizedBox(
                height: 30,
              ),
              DefaultTextFiled(
                taskController: decriptEditController,
                hint: 'Task Description',
                maxlines: 2,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text('Select date :',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 18,
                          ),
                      textAlign: TextAlign.start),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                child: Text(
                  '${formatdate.format(argument.date)}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primary),
                ),
                onPressed: () async {
                  DateTime? dateTime = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now().subtract(Duration(days: 30)),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                    initialDate: argument.date,
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                  );
                  if (dateTime != null) {
                    argument.date = dateTime;
                    setState(() {});
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 45.h, horizontal: 25.w),
                child: DefaultButton(
                    lable: 'Save Changes',
                    onpress: () {
                      if (titleEditController.text.trim() != argument.title ||
                          decriptEditController.text.trim() !=
                              argument.description ||
                          selecteddate != argument.date) {
                        tasksProvider.updatetask(
                          argument.id,
                          {
                            'title': titleEditController.text,
                            'description': decriptEditController.text,
                            'date': Timestamp.fromDate(argument.date),
                          },
                          Provider.of<UserProvider>(context, listen: false)
                              .currentUser!
                              .id,
                        );

                        print(selecteddate.toString());
                        Navigator.of(context).pop();
                        tasksProvider.getalltasks(
                          Provider.of<UserProvider>(context, listen: false)
                              .currentUser!
                              .id,
                        );
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
