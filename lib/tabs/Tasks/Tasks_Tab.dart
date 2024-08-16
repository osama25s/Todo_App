// ignore_for_file: prefer_const_constructors

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/App_Theme.dart';
import 'package:todo_app/tabs/Tasks/Task_Item.dart';
import 'package:todo_app/tabs/Tasks/tasks_provider.dart';

class TasksTab extends StatelessWidget {
  TasksTab({super.key});
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 220.h,
              color: Theme.of(context).primaryColor,
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(top: 75.h, start: 20.w),
              child: Text(
                'To Do List',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppTheme.white, fontSize: 25.sp),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(top: 170.h),
              child: EasyInfiniteDateTimeLine(
                firstDate: DateTime.now().subtract(Duration(days: 30)),
                lastDate: DateTime.now().add(Duration(days: 30)),
                focusDate: tasksProvider.selectedDate,
                showTimelineHeader: false,
                onDateChange: (focusDate) {
                  tasksProvider.changedate(focusDate);
                  tasksProvider.getalltasks();
                },
                activeColor: AppTheme.white,
                dayProps: EasyDayProps(
                  activeDayStyle: DayStyle(
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(
                          color: AppTheme.black,
                          width: 2,
                        )),
                    dayNumStyle: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: AppTheme.black),
                    monthStrStyle: TextStyle(
                      color: Colors.transparent,
                    ),
                    dayStrStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  todayStyle: DayStyle(
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(
                          color: AppTheme.primary,
                          width: 2,
                        )),
                    dayNumStyle: Theme.of(context).textTheme.titleLarge,
                    monthStrStyle: TextStyle(
                      color: Colors.transparent,
                    ),
                    dayStrStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primary),
                  ),
                  inactiveDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    monthStrStyle: TextStyle(
                      color: Colors.transparent,
                    ),
                    dayNumStyle: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: AppTheme.black),
                    dayStrStyle: Theme.of(context).textTheme.titleSmall,
                  ),
                  disabledDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    monthStrStyle: TextStyle(
                      color: Colors.transparent,
                    ),
                    dayNumStyle: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: AppTheme.black),
                  ),
                  height: 80.h,
                ),
              ),
            ),
          ],
        ),
        Expanded(
            child: ListView.builder(
          padding: EdgeInsets.only(top: 20),
          itemBuilder: (context, index) =>
              Task_Item(tasksProvider.tasks[index]),
          itemCount: tasksProvider.tasks.length,
        )),
      ],
    );
  }
}
