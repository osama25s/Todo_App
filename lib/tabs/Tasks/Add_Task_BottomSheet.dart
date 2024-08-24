import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/App_Theme.dart';
import 'package:todo_app/firebase_service.dart';
import 'package:todo_app/models/Task_Model.dart';
import 'package:todo_app/models/User_Model.dart';
import 'package:todo_app/tabs/Authentication/User_Provider.dart';
import 'package:todo_app/tabs/Settings/Settings_Provider.dart';
import 'package:todo_app/tabs/Tasks/default_Button.dart';
import 'package:todo_app/tabs/Tasks/default_TextFormFiled.dart';
import 'package:todo_app/tabs/Tasks/tasks_provider.dart';

class TaskBottomSheet extends StatefulWidget {
  const TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SettingsPrvider settingsPrvider = Provider.of<SettingsPrvider>(context);
    return Container(
      color: settingsPrvider.themeMode == ThemeMode.dark
          ? AppTheme.darkBG
          : AppTheme.white,
      padding: EdgeInsets.all(16),
      child: Form(
        key: formkey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Text(
                'Add new Task',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: settingsPrvider.themeMode == ThemeMode.dark
                          ? AppTheme.white
                          : AppTheme.black,
                    ),
              ),
            ),
            DefaultTextFiled(
              taskController: titlecontroller,
              hint: 'enter task title',
              validate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'task title can not be empty';
                }
                return null;
              },
            ),
            SizedBox(
              height: 18.h,
            ),
            DefaultTextFiled(
              taskController: descriptionController,
              hint: 'enter task description',
              maxlines: 3,
              validate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'task title can not be empty';
                }
                return null;
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.h, bottom: 35.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'select date :',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontSize: 16.sp),
                  ),
                  InkWell(
                    child: Text(
                      dateFormat.format(selectedDate),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppTheme.primary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    onTap: () async {
                      DateTime? dateTime = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                          initialDate: selectedDate,
                          initialEntryMode: DatePickerEntryMode.calendarOnly);

                      if (dateTime != null) {
                        selectedDate = dateTime;
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
            ),
            DefaultButton(
              lable: 'submit',
              onpress: () {
                if (formkey.currentState!.validate()) {
                  addtask();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void addtask() {
    FireBaseService.addtask(
      TaskModel(
          title: titlecontroller.text,
          description: descriptionController.text,
          date: selectedDate),
      Provider.of<UserProvider>(context, listen: false).currentUser!.id,
    ).then((_) {
      print('task added');
      Navigator.of(context).pop();
      Provider.of<TasksProvider>(context, listen: false).getalltasks(
        Provider.of<UserProvider>(context, listen: false).currentUser!.id,
      );
      Fluttertoast.showToast(
          msg: "Task added Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppTheme.green,
          textColor: Colors.white,
          fontSize: 18.0);
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: "Failed to add Task",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppTheme.red,
          textColor: Colors.white,
          fontSize: 18.0);
    });
  }
}
