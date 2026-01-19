class TodoModel {
  int? id;
  String taskName;
  String description;
  DateTime dateTime;
  bool isCompleted;
  bool isPriority;

  TodoModel({
    this.id,
    required this.taskName,
    required this.description,
    required this.dateTime,
    this.isCompleted = false,
    this.isPriority = false,
  });

  // ---------------------------
  // SQLite mapper (1 / 0)
  // ---------------------------
  Map<String, dynamic> toSqliteMap() {
    return {
      "id": id,
      "taskname": taskName,
      "description": description,
      "datetime": dateTime.toIso8601String(),
      "iscompleted": isCompleted ? 1 : 0,
      "ispriority": isPriority ? 1 : 0,
    };
  }

  // ---------------------------
  // Supabase mapper (true / false)
  // ---------------------------
  Map<String, dynamic> toSupabaseMap() {
    return {
      "id": id,
      "taskname": taskName,
      "description": description,
      "datetime": dateTime.toIso8601String(),
      "iscompleted": isCompleted,
      "ispriority": isPriority,
    };
  }

  // ---------------------------
  // From DB (works for both)
  // ---------------------------
  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      taskName: map['taskname'],
      description: map['description'],
      dateTime: DateTime.parse(map['datetime']),
      isCompleted: map['iscompleted'] == 1 || map['iscompleted'] == true,
      isPriority: map['ispriority'] == 1 || map['ispriority'] == true,
    );
  }
}
