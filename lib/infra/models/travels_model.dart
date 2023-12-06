class TravelsModel {
  String id, travel, color;
  int numberOfTasks;
  int completedTasks;
  DateTime startAt;
  DateTime endAt;

  TravelsModel(
    this.id,
    this.travel,
    this.color,
    this.startAt,
    this.endAt, {
    this.numberOfTasks = 0,
    this.completedTasks = 0,
  });
}
