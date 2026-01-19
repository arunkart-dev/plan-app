import 'package:flutter/material.dart';
import 'package:make_plan/model/roadmap_step_model.dart';
import 'package:make_plan/model/roadmap_model.dart';
import 'package:make_plan/data/local/roadmap/roadmap_dao.dart';
import 'package:make_plan/services/supabase_service.dart';

class RoadmapProvider extends ChangeNotifier {
  final RoadmapDao _dao = RoadmapDao();
  final SupabaseService _supabase = SupabaseService();

  RoadmapModel? _currentRoadmap;
  RoadmapModel? get currentRoadmap => _currentRoadmap;

  // ======================
  // LOAD (SQLite → Supabase)
  // ======================
  Future<void> loadRoadmapFromDB(String category) async {
    // 1️⃣ SQLite
    final all = await _dao.getAllRoadmaps();
    try {
      _currentRoadmap = all.firstWhere((r) => r.category == category);
      notifyListeners();
    } catch (_) {
      _currentRoadmap = null;
      notifyListeners();
    }

    // 2️⃣ Supabase
    try {
      final remote = await _supabase.fetchRoadmapsWithSteps();
      final found = remote.where((r) => r.category == category);
      if (found.isNotEmpty) {
        _currentRoadmap = found.first;
        notifyListeners();
      }
    } catch (_) {
      // offline → ignore
    }
  }

  // ======================
  // 📘 STUDY ROADMAP
  // ======================
  Future<void> loadStudyRoadmap() async {
    await _loadOrCreateRoadmap(
      category: "Study",
      steps: _defaultStudySteps(),
    );
  }

  // ======================
  // 💼 CAREER ROADMAP
  // ======================
  Future<void> loadCareerRoadmap() async {
    await _loadOrCreateRoadmap(
      category: "Career",
      steps: _defaultCareerSteps(),
    );
  }

  // ======================
  // 🏋️ FITNESS ROADMAP
  // ======================
  Future<void> loadFitnessRoadmap() async {
    await _loadOrCreateRoadmap(
      category: "Fitness",
      steps: _defaultFitnessSteps(),
    );
  }

  // ======================
  // CORE: load or create
  // ======================
  Future<void> _loadOrCreateRoadmap({
    required String category,
    required List<RoadmapStep> steps,
  }) async {
    // 1️⃣ Try SQLite
    final all = await _dao.getAllRoadmaps();
    try {
      _currentRoadmap = all.firstWhere((r) => r.category == category);
      notifyListeners();
      return;
    } catch (_) {}

    // 2️⃣ Try Supabase
    try {
      final remote = await _supabase.fetchRoadmapsWithSteps();
      final found = remote.where((r) => r.category == category);
      if (found.isNotEmpty) {
        _currentRoadmap = found.first;
        notifyListeners();
        return;
      }
    } catch (_) {}

    // 3️⃣ Create new roadmap
    final roadmap = RoadmapModel(
      category: category,
      steps: steps,
    );

    // SQLite
    await _dao.insertRoadmap(roadmap);

    // Supabase
    try {
      final roadmapId = await _supabase.addRoadmap(roadmap);
      for (final step in steps) {
        step.roadmapId = roadmapId;
      }
      await _supabase.addRoadmapSteps(steps);
    } catch (_) {}

    await loadRoadmapFromDB(category);
  }

  // ======================
  // ✔️ TOGGLE STEP STATUS
  // ======================
  Future<void> toggleStep(int index) async {
    if (_currentRoadmap == null) return;

    final step = _currentRoadmap!.steps[index];
    step.isCompleted = !step.isCompleted;

    notifyListeners();

    // SQLite
    await _dao.updateStep(step);

    // Supabase
    try {
      await _supabase.updateRoadmapStep(step);
    } catch (_) {}
  }

  // ======================
  // DEFAULT STEPS
  // ======================
  List<RoadmapStep> _defaultStudySteps() => [
        RoadmapStep(
          title: "Basics",
          description: "Learn the fundamentals of your subject.",
        ),
        RoadmapStep(
          title: "Core Concepts",
          description: "Understand the main topics deeply.",
        ),
        RoadmapStep(
          title: "Practice",
          description: "Solve problems and build small projects.",
        ),
        RoadmapStep(
          title: "Advanced Topics",
          description: "Learn best practices and optimization.",
        ),
        RoadmapStep(
          title: "Mastery",
          description: "Build real projects and teach others.",
        ),
      ];

  List<RoadmapStep> _defaultCareerSteps() => [
        RoadmapStep(
          title: "Skill Foundation",
          description: "Learn the core skills needed for your career path.",
        ),
        RoadmapStep(
          title: "Mini Projects",
          description: "Build small projects to apply what you learn.",
        ),
        RoadmapStep(
          title: "Major Project",
          description: "Create one strong project for your portfolio.",
        ),
        RoadmapStep(
          title: "Internship / Freelance",
          description:
              "Gain real-world experience by working with others.",
        ),
        RoadmapStep(
          title: "Job / Startup",
          description:
              "Apply for jobs or start building your own product.",
        ),
      ];

  List<RoadmapStep> _defaultFitnessSteps() => [
        RoadmapStep(
          title: "Start Moving",
          description: "Begin with light exercises and daily walking.",
        ),
        RoadmapStep(
          title: "Build Habit",
          description: "Exercise at least 4 days a week consistently.",
        ),
        RoadmapStep(
          title: "Increase Intensity",
          description:
              "Add strength training and longer workout sessions.",
        ),
        RoadmapStep(
          title: "Track Progress",
          description:
              "Monitor weight, stamina, and overall fitness levels.",
        ),
        RoadmapStep(
          title: "Lifestyle Change",
          description:
              "Make fitness a permanent part of your daily routine.",
        ),
      ];
}
