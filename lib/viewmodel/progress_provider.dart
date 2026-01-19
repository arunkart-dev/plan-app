import 'package:flutter/material.dart';
import 'package:make_plan/services/supabase_service.dart';
import '../model/todo_model.dart';
import '../data/local/todo/todo_dao.dart';

class ProgressProvider extends ChangeNotifier {
  final TodoDao _dao = TodoDao();
  final SupabaseService _supabase = SupabaseService();

  List<TodoModel> _todos = [];

  // ---------------- LOAD ----------------

  /// Load progress from SQLite first, then Supabase
  Future<void> loadProgress() async {
    // 1️⃣ Load from SQLite
    _todos = await _dao.getAllTodos();
    notifyListeners();

    // 2️⃣ Try fetch from Supabase
    try {
      final remoteTodos = await _supabase.fetchTodos();
      _todos = remoteTodos;
      notifyListeners();
    } catch (_) {
      // offline → keep SQLite data
    }
  }

  /// Called when TodoProvider changes
  void updateTodos(List<TodoModel> todos) {
    _todos = List.from(todos); // defensive copy
    notifyListeners();
  }

  // ---------------- METRICS ----------------

  int get totalTasks => _todos.length;

  int get completedTasks =>
      _todos.where((t) => t.isCompleted).length;

  int get pendingTasks => totalTasks - completedTasks;

  // ---------------- CHART DATA ----------------

  List<double> get progressPoints {
    if (_todos.isEmpty) return [];

    int completedCount = 0;
    final List<double> points = [];

    for (final todo in _todos) {
      if (todo.isCompleted) {
        completedCount++;
      }
      points.add(completedCount.toDouble());
    }

    return points;
  }

  // ---------------- SCORE ----------------

  int get consistencyScore {
    if (totalTasks == 0) return 0;
    return ((completedTasks / totalTasks) * 100).round();
  }

  // ---------------- SUMMARY ----------------

  String get summaryText {
    if (totalTasks == 0) {
      return "Start adding tasks to see your progress.";
    }

    if (consistencyScore >= 80) {
      return "Excellent consistency! You're completing most of your tasks.";
    } else if (consistencyScore >= 50) {
      return "Good progress. Stay consistent to improve further.";
    } else {
      return "Low consistency. Try completing tasks daily to build momentum.";
    }
  }
}
