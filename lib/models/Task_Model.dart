class TaskModel {
  String title;
  String description;
  DateTime date;
  bool isDone;
  TaskModel(
      {required this.title,
      required this.description,
      required this.date,
      this.isDone = false});
}
