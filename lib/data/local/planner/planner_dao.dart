import '../core/db_helper.dart';
import '../../../model/planner_model.dart';

class PlannerDao {

  Future<int> insertPlanner(PlannerModel planner) async {
    final db = await DBHelper.database;
    return await db.insert('planners', planner.toSqliteMap());
  }

  Future<List<PlannerModel>> getAllPlanners() async {
    final db = await DBHelper.database;
    final result = await db.query(
      'planners',
      orderBy: 'date ASC',
    );
    return result.map((e) => PlannerModel.fromMap(e)).toList();
  }

  Future<List<PlannerModel>> getPlannersByDate(DateTime date) async {
    final db = await DBHelper.database;
    final day = date.toIso8601String().split('T').first;

    final result = await db.query(
      'planners',
      where: "date LIKE ?",
      whereArgs: ['$day%'],
      orderBy: 'date ASC',
    );

    return result.map((e) => PlannerModel.fromMap(e)).toList();
  }

  Future<int> updatePlanner(PlannerModel planner) async {
    final db = await DBHelper.database;
    return await db.update(
      'planners',
      planner.toSqliteMap(),
      where: 'id = ?',
      whereArgs: [planner.id],
    );
  }

  Future<int> deletePlanner(int id) async {
    final db = await DBHelper.database;
    return await db.delete(
      'planners',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
