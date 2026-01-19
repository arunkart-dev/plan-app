
import '../core/db_helper.dart';
import '../../../model/todo_model.dart';

class TodoDao {

  Future<int> insertTodo(TodoModel todo) async {
    final db = await DBHelper.database;
    return await db.insert('todos', todo.toSqliteMap());
  }

  Future<List<TodoModel>> getAllTodos() async {
    final db = await DBHelper.database;
    final result = await db.query('todos', orderBy: 'datetime DESC');
    return result.map((e) => TodoModel.fromMap(e)).toList();
  }

  Future<int> updateTodo(TodoModel todo) async {
    final db = await DBHelper.database;
    return await db.update(
      'todos',
      todo.toSqliteMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> deleteTodo(int id) async {
    final db = await DBHelper.database;
    return await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<TodoModel>> getPriorityTodos() async {
    final db = await DBHelper.database;
    final result = await db.query(
      'todos',
      where: 'ispriority = ?',
      whereArgs: [1],
      orderBy: 'datetime DESC',
    );
    return result.map((e) => TodoModel.fromMap(e)).toList();
  }
}
