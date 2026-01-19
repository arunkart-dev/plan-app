class RoadmapStep {
  int? id;          // DB id
  int? roadmapId;  // FK → roadmaps table

  final String title;
  final String description;
  bool isCompleted;

  RoadmapStep({
    this.id,
    this.roadmapId,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  // ---------------------------
  // SQLite mapper (1 / 0)
  // ---------------------------
  Map<String, dynamic> toSqliteMap() {
    return {
      'id': id,
      'roadmap_id': roadmapId,
      'title': title,
      'description': description,
      'iscompleted': isCompleted ? 1 : 0,
    };
  }

  // ---------------------------
  // Supabase mapper (true / false)
  // ---------------------------
  Map<String, dynamic> toSupabaseMap() {
    return {
      'id': id,
      'roadmap_id': roadmapId,
      'title': title,
      'description': description,
      'iscompleted': isCompleted,
    };
  }

  // ---------------------------
  // From DB (works for both)
  // ---------------------------
  factory RoadmapStep.fromMap(Map<String, dynamic> map) {
    return RoadmapStep(
      id: map['id'],
      roadmapId: map['roadmap_id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['iscompleted'] == 1 || map['iscompleted'] == true,
    );
  }
}
