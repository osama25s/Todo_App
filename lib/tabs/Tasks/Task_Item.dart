import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/App_Theme.dart';
import 'package:todo_app/firebase_service.dart';
import 'package:todo_app/models/Task_Model.dart';
import 'package:todo_app/tabs/Authentication/User_Provider.dart';
import 'package:todo_app/tabs/Tasks/EditTask_Tab.dart';
import 'package:todo_app/tabs/Tasks/tasks_provider.dart';

class Task_Item extends StatefulWidget {
  TaskModel taskModel;
  Task_Item(this.taskModel);

  @override
  State<Task_Item> createState() => _Task_ItemState();
}

class _Task_ItemState extends State<Task_Item> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Slidable(
        key: const ValueKey(0),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {
            FireBaseService.deletetask(
              widget.taskModel.id,
              Provider.of<UserProvider>(context, listen: false).currentUser!.id,
            ).then((_) {
              Fluttertoast.showToast(
                  msg: "Task Deleted",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: AppTheme.red,
                  textColor: Colors.white,
                  fontSize: 18.0);
              Provider.of<TasksProvider>(context, listen: false).getalltasks(
                Provider.of<UserProvider>(context, listen: false)
                    .currentUser!
                    .id,
              );
            }).catchError((error) {});
          }),
          children: [
            SlidableAction(
              onPressed: (_) {
                FireBaseService.deletetask(
                  widget.taskModel.id,
                  Provider.of<UserProvider>(context, listen: false)
                      .currentUser!
                      .id,
                ).then((_) {
                  Fluttertoast.showToast(
                      msg: "Task Deleted",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: AppTheme.red,
                      textColor: Colors.white,
                      fontSize: 18.0);
                  Provider.of<TasksProvider>(context, listen: false)
                      .getalltasks(
                    Provider.of<UserProvider>(context, listen: false)
                        .currentUser!
                        .id,
                  );
                }).catchError((error) {});
              },
              backgroundColor: AppTheme.red,
              foregroundColor: AppTheme.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.circular(15.r),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, EditTask_Tab.routname,
                arguments: widget.taskModel);
          },
          child: Container(
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: AppTheme.white),
            child: Row(
              children: [
                Container(
                  height: 62.h,
                  width: 4.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: widget.taskModel.isDone
                          ? AppTheme.green
                          : AppTheme.primary),
                  margin: EdgeInsetsDirectional.only(end: 8),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.taskModel.title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: widget.taskModel.isDone
                              ? AppTheme.green
                              : AppTheme.primary),
                    ),
                    Text(
                      widget.taskModel.description,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                Spacer(),
                widget.taskModel.isDone
                    ? TextButton(
                        child: Text(
                          'Done!',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: AppTheme.green),
                        ),
                        onPressed: () {
                          setdone();
                          setState(() {});
                        },
                      )
                    : InkWell(
                        child: Container(
                          width: 69.w,
                          height: 39.h,
                          decoration: BoxDecoration(
                              color: AppTheme.primary,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Icon(
                            Icons.check,
                            color: AppTheme.white,
                            size: 32,
                          ),
                        ),
                        onTap: () {
                          setdone();
                          setState(() {});
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setdone() {
    widget.taskModel.isDone = !widget.taskModel.isDone;
    FireBaseService.edittask(
      widget.taskModel.id,
      {'isDone': widget.taskModel.isDone},
      Provider.of<UserProvider>(context, listen: false).currentUser!.id,
    );
    setState(() {});
  }
}
