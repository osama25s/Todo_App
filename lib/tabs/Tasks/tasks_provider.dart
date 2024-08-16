import 'package:flutter/material.dart';
import 'package:todo_app/firebase_service.dart';
import 'package:todo_app/models/Task_Model.dart';

class TasksProvider extends ChangeNotifier {
  TasksProvider() {
    getalltasks();
  }
  List<TaskModel> tasks = [];
  DateTime selectedDate = DateTime.now();

  Future<void> getalltasks() async {
    List<TaskModel> alltasks = await FireBaseService.gettasks();
    tasks = alltasks
        .where((task) =>
            task.date.day == selectedDate.day &&
            task.date.month == selectedDate.month &&
            task.date.year == selectedDate.year)
        .toList();
    notifyListeners();
  }

  void changedate(DateTime changeddate) {
    selectedDate = changeddate;
    notifyListeners();
  }

  void updatetask(String id, Map<String, dynamic> data) async {
    await FireBaseService.edittask(id, data);
  }
}
