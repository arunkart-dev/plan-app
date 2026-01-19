import 'package:flutter/material.dart';
import 'package:make_plan/model/todo_model.dart';
import 'package:make_plan/data/local/todo/todo_dao.dart';
import 'package:make_plan/services/supabase_service.dart';

class TodoProvider extends ChangeNotifier {
  final TodoDao _dao = TodoDao();
  final SupabaseService _supabase = SupabaseService();

  final List<TodoModel> _todos = [];
  List<TodoModel> get todos => _todos;

  // ---------------- FILTERS ----------------

  List<TodoModel> get completedTodos =>
      _todos.where((t) => t.isCompleted).toList();

  List<TodoModel> get pendingTodos =>
      _todos.where((t) => !t.isCompleted).toList();

  List<TodoModel> get priorityTodos =>
      _todos.where((t) => t.isPriority).toList();

  // ---------------- SEARCH ----------------

  List<TodoModel> searchTodos(String query) {
    if (query.isEmpty) return _todos;

    return _todos.where((todo) {
      return todo.taskName.toLowerCase().contains(query) ||
          todo.description.toLowerCase().contains(query);
    }).toList();
  }

  // ---------------- LOAD ----------------

  Future<void> loadTodos() async {
    // 1️⃣ Load from SQLite
    final data = await _dao.getAllTodos();
    _todos
      ..clear()
      ..addAll(data);
    notifyListeners();

    // 2️⃣ Try sync from Supabase (non-blocking)
    try {
      final remoteTodos = await _supabase.fetchTodos();
      _todos
        ..clear()
        ..addAll(remoteTodos);
      notifyListeners();
    } catch (_) {
      // offline → ignore
    }
  }

  // ---------------- ADD ----------------

  Future<void> add(TodoModel todo) async {
    // 1️⃣ Save locally
    final id = await _dao.insertTodo(todo);
    todo.id = id;
    _todos.add(todo);
    notifyListeners();

    // 2️⃣ Save to Supabase
    try {
      await _supabase.addTodo(todo);
    } catch (_) {
      // later sync
    }
  }

  // ---------------- EDIT ----------------

  Future<void> edit(int id, TodoModel updatedtodo) async {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index == -1) return;

    updatedtodo.id = id;
    _todos[index] = updatedtodo;
    notifyListeners();

    // SQLite
    await _dao.updateTodo(updatedtodo);

    // Supabase
    try {
      await _supabase.updateTodo(updatedtodo);
    } catch (_) {}
  }

  // ---------------- DELETE ----------------

  Future<void> delete(int id) async {
    // SQLite
    await _dao.deleteTodo(id);

    _todos.removeWhere((t) => t.id == id);
    notifyListeners();

    // Supabase
    try {
      await _supabase.deleteTodo(id);
    } catch (_) {}
  }

  // ---------------- TOGGLE DONE ----------------

  Future<void> toggletodo(int id) async {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index == -1) return;

    _todos[index].isCompleted = !_todos[index].isCompleted;
    notifyListeners();

    // SQLite
    await _dao.updateTodo(_todos[index]);

    // Supabase
    try {
      await _supabase.updateTodo(_todos[index]);
    } catch (_) {}
  }

  // ---------------- TOGGLE PRIORITY ----------------

  Future<void> togglePriority(int id) async {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index == -1) return;

    _todos[index].isPriority = !_todos[index].isPriority;
    notifyListeners();

    // SQLite
    await _dao.updateTodo(_todos[index]);

    // Supabase
    try {
      await _supabase.updateTodo(_todos[index]);
    } catch (_) {}
  }

  // ---------------- PIE CHART DATA ----------------

  int get priorityCompletedCount =>
      priorityTodos.where((t) => t.isCompleted).length;

  int get priorityPendingCount =>
      priorityTodos.where((t) => !t.isCompleted).length;
}
