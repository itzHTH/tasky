class TaskModel {
  int id;
  String taskName;
  String? taskDescription;
  bool isHighPriority;
  bool isDone = false;

  TaskModel({
    required this.id,
    required this.taskName,
    this.taskDescription,
    required this.isHighPriority,
    this.isDone = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> task) {
    return TaskModel(
      id: task["id"],
      taskName: task["taskName"],
      taskDescription: task["taskDescription"],
      isHighPriority: task["isHighPriority"],
      isDone: task["isDone"] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "taskName": taskName,
      "taskDescription": taskDescription,
      "isHighPriority": isHighPriority,
      "isDone": isDone,
    };
  }
}
