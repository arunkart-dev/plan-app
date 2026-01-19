class PlannerModel {
  int? id;
  String title;
  DateTime date;
  bool isCompleted;

  PlannerModel({
    this.id,
    required this.title,
    required this.date,
    this.isCompleted = false,
  });

  // ---------------------------
  // SQLite mapper (1 / 0)
  // ---------------------------
  Map<String, dynamic> toSqliteMap() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'iscompleted': isCompleted ? 1 : 0,
    };
  }

  // ---------------------------
  // Supabase mapper (true / false)
  // ---------------------------
  Map<String, dynamic> toSupabaseMap() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'iscompleted': isCompleted,
    };
  }

  // ---------------------------
  // From DB (works for both)
  // ---------------------------
  factory PlannerModel.fromMap(Map<String, dynamic> map) {
    return PlannerModel(
      id: map['id'],
      title: map['title'],
      date: DateTime.parse(map['date']),
      isCompleted: map['iscompleted'] == 1 || map['iscompleted'] == true,
    );
  }

}
