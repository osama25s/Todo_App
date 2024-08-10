import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/Task_Model.dart';
import 'package:todo_app/tabs/Tasks/Task_Item.dart';

class TasksTab extends StatelessWidget {
  TasksTab({super.key});
  List<TaskModel> tasks = List.generate(
    15,
    (index) => TaskModel(
      title: 'Task Title ${index + 1}',
      description: 'Task description ${index + 1}',
      date: DateTime.now(),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          EasyInfiniteDateTimeLine(
            firstDate: DateTime.now().subtract(Duration(days: 30)),
            lastDate: DateTime.now().add(Duration(days: 30)),
            focusDate: DateTime.now(),
            showTimelineHeader: false,
          ),
          Expanded(
              child: ListView.builder(
            padding: EdgeInsets.only(top: 20),
            itemBuilder: (context, index) => Task_Item(tasks[index]),
            itemCount: tasks.length,
          )),
        ],
      ),
    );
  }
}
