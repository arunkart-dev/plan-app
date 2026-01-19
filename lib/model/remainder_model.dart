class Reminder {
  final String id;
  final String taskId;
  final DateTime remindAt;
  final String type; // time | before_deadline | smart
  final bool isEnabled;

  Reminder({
    required this.id,
    required this.taskId,
    required this.remindAt,
    required this.type,
    required this.isEnabled,
  });

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      id: map['id'],
      taskId: map['task_id'],
      remindAt: DateTime.parse(map['remind_at']),
      type: map['type'],
      isEnabled: map['is_enabled'],
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'task_id': taskId,
    'remind_at': remindAt.toIso8601String(),
    'type': type,
    'is_enabled': isEnabled,
  };
}
