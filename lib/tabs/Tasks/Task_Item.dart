import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/App_Theme.dart';
import 'package:todo_app/firebase_service.dart';
import 'package:todo_app/models/Task_Model.dart';
import 'package:todo_app/tabs/Tasks/EditTask_Tab.dart';

class Task_Item extends StatefulWidget {
  TaskModel taskModel;
  Task_Item(this.taskModel);

  @override
  State<Task_Item> createState() => _Task_ItemState();
}

class _Task_ItemState extends State<Task_Item> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, EditTask_Tab.routname,
            arguments: widget.taskModel);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r), color: AppTheme.white),
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
    );
  }

  void setdone() {
    widget.taskModel.isDone = !widget.taskModel.isDone;
    FireBaseService.edittask(
        widget.taskModel.id, {'isDone': widget.taskModel.isDone});
    setState(() {});
  }
}
