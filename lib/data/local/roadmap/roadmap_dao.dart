import '../core/db_helper.dart';
import '../../../model/roadmap_model.dart';
import '../../../model/roadmap_step_model.dart';

class RoadmapDao {

  // -------- INSERT ROADMAP + STEPS --------
  Future<int> insertRoadmap(RoadmapModel roadmap) async {
    final db = await DBHelper.database;

    final roadmapId = await db.insert(
      'roadmaps',
      {'category': roadmap.category},
    );

    for (var step in roadmap.steps) {
      step.roadmapId = roadmapId;
      await db.insert('roadmap_steps', step.toSqliteMap());
    }

    return roadmapId;
  }

  // -------- GET ALL ROADMAPS --------
  Future<List<RoadmapModel>> getAllRoadmaps() async {
    final db = await DBHelper.database;

    final roadmapRows = await db.query('roadmaps');
    List<RoadmapModel> roadmaps = [];

    for (var row in roadmapRows) {
      final stepsRows = await db.query(
        'roadmap_steps',
        where: 'roadmap_id = ?',   // ✅ FIXED
        whereArgs: [row['id']],
      );

      final steps =
          stepsRows.map((e) => RoadmapStep.fromMap(e)).toList();

      roadmaps.add(
        RoadmapModel(
          id: row['id'] as int,
          category: row['category'] as String,
          steps: steps,
        ),
      );
    }

    return roadmaps;
  }

  // -------- UPDATE STEP --------
  Future<void> updateStep(RoadmapStep step) async {
    final db = await DBHelper.database;
    await db.update(
      'roadmap_steps',
      step.toSqliteMap(),
      where: 'id = ?',
      whereArgs: [step.id],
    );
  }

  // -------- DELETE ROADMAP --------
  Future<void> deleteRoadmap(int roadmapId) async {
    final db = await DBHelper.database;
    await db.delete(
      'roadmaps',
      where: 'id = ?',
      whereArgs: [roadmapId],
    );
  }
}
