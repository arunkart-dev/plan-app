import 'package:flutter/material.dart';
import 'package:make_plan/services/supabase_service.dart';
import '../model/planner_model.dart';
import '../data/local/planner/planner_dao.dart';


class PlannerProvider extends ChangeNotifier {
  final PlannerDao _dao = PlannerDao();
  final SupabaseService _supabase = SupabaseService();

  final List<PlannerModel> _plans = [];
  List<PlannerModel> get allPlans => _plans;

  // 📅 today plans
  List<PlannerModel> get todayPlans {
    final now = DateTime.now();
    return _plans.where((p) =>
        p.date.year == now.year &&
        p.date.month == now.month &&
        p.date.day == now.day).toList();
  }

  // ---------------- LOAD ----------------

  Future<void> loadPlans() async {
    // 1️⃣ Load from SQLite
    final data = await _dao.getAllPlanners();
    _plans
      ..clear()
      ..addAll(data);
    notifyListeners();

    // 2️⃣ Try fetch from Supabase
    try {
      final remotePlans = await _supabase.fetchPlanners();
      _plans
        ..clear()
        ..addAll(remotePlans);
      notifyListeners();
    } catch (_) {
      // offline → ignore
    }
  }

  // ---------------- ADD ----------------

  Future<void> addPlan(PlannerModel plan) async {
    // 1️⃣ Save locally
    final id = await _dao.insertPlanner(plan);
    plan.id = id;
    _plans.add(plan);
    notifyListeners();

    // 2️⃣ Save to Supabase
    try {
      await _supabase.addPlanner(plan);
    } catch (_) {
      // will sync later
    }
  }

  // ---------------- TOGGLE DONE ----------------

  Future<void> togglePlan(int id) async {
    final index = _plans.indexWhere((p) => p.id == id);
    if (index == -1) return;

    _plans[index].isCompleted = !_plans[index].isCompleted;
    notifyListeners();

    // SQLite
    await _dao.updatePlanner(_plans[index]);

    // Supabase
    try {
      await _supabase.addPlanner(_plans[index]); // upsert-style save
    } catch (_) {}
  }

  // ---------------- DELETE ----------------

  Future<void> deletePlan(int id) async {
    // SQLite
    await _dao.deletePlanner(id);

    _plans.removeWhere((p) => p.id == id);
    notifyListeners();

    // Supabase
    try {
      await _supabase.deleteTodo(id); // reuse delete method or create deletePlanner()
    } catch (_) {}
  }
}
