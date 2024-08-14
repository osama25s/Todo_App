import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/tabs/Tasks/Task_Item.dart';
import 'package:todo_app/tabs/Tasks/tasks_provider.dart';

class TasksTab extends StatelessWidget {
  TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    return SafeArea(
      child: Column(
        children: [
          EasyInfiniteDateTimeLine(
            firstDate: DateTime.now().subtract(Duration(days: 30)),
            lastDate: DateTime.now().add(Duration(days: 30)),
            focusDate: tasksProvider.selectedDate,
            showTimelineHeader: false,
            onDateChange: (focusDate) {
              tasksProvider.changedate(focusDate);
              tasksProvider.getalltasks();
            },
          ),
          Expanded(
              child: ListView.builder(
            padding: EdgeInsets.only(top: 20),
            itemBuilder: (context, index) =>
                Task_Item(tasksProvider.tasks[index]),
            itemCount: tasksProvider.tasks.length,
          )),
        ],
      ),
    );
  }
}
