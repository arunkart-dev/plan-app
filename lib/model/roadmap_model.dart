import 'package:make_plan/model/roadmap_step_model.dart';

class RoadmapModel {
  int? id;
  String category;
  List<RoadmapStep> steps;

  RoadmapModel({
    this.id,
    required this.category,
    required this.steps,
  });

  // Supabase
  Map<String, dynamic> toSupabaseMap(String userId) {
    return {
      'id': id,
      'category': category,
      'user_id': userId,
    };
  }

  // SQLite
  Map<String, dynamic> toSqliteMap() {
    return {
      'id': id,
      'category': category,
    };
  }
}
