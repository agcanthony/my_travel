class TasksModel {
  String id;
  bool isDone;
  String task;
  String? description;
  DateTime? dateTime;

  TasksModel(
    this.id,
    this.isDone,
    this.task, {
    this.description,
    this.dateTime,
  });
}
