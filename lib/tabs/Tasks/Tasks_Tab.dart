// ignore_for_file: prefer_const_constructors

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/App_Theme.dart';
import 'package:todo_app/tabs/Authentication/User_Provider.dart';
import 'package:todo_app/tabs/Tasks/Task_Item.dart';
import 'package:todo_app/tabs/Tasks/tasks_provider.dart';

class TasksTab extends StatelessWidget {
  TasksTab({super.key});
  bool gettask = true;
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    if (gettask) {
      tasksProvider.getalltasks(
          Provider.of<UserProvider>(context, listen: false).currentUser!.id);
      gettask = false;
    }
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
                  tasksProvider.getalltasks(
                    Provider.of<UserProvider>(context, listen: false)
                        .currentUser!
                        .id,
                  );
                },
                activeColor: AppTheme.white,
                dayProps: EasyDayProps(
                  dayStructure: DayStructure.dayNumDayStr,
                  width: 60.w,
                  height: 85.h,
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
                    dayStrStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(
                            fontWeight: FontWeight.w600, color: AppTheme.black),
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
                    dayNumStyle: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: AppTheme.black),
                    dayStrStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(
                            fontWeight: FontWeight.w200,
                            fontSize: 12,
                            color: AppTheme.black),
                  ),
                  disabledDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    dayNumStyle: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: AppTheme.black),
                  ),
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
