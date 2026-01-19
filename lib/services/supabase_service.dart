import 'package:make_plan/model/chat_message_model.dart';
import 'package:make_plan/model/planner_model.dart';
import 'package:make_plan/model/profile_model.dart';
import 'package:make_plan/model/roadmap_model.dart';
import 'package:make_plan/model/roadmap_step_model.dart';
import 'package:make_plan/model/todo_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  // -----------------------------
  // AUTH
  // -----------------------------
  User? get currentUser => _client.auth.currentUser;

  // -----------------------------
  // TODO
  // -----------------------------
  Future<void> addTodo(TodoModel todo) async {
    await _client.from('todos').insert(todo.toSupabaseMap());
  }

  Future<List<TodoModel>> fetchTodos() async {
    final res = await _client.from('todos').select().order('datetime');
    return (res as List)
        .map((e) => TodoModel.fromMap(e))
        .toList();
  }

  Future<void> updateTodo(TodoModel todo) async {
    await _client
        .from('todos')
        .update(todo.toSupabaseMap())
        .eq('id', todo.id!);
  }

  Future<void> deleteTodo(int id) async {
    await _client.from('todos').delete().eq('id', id);
  }

  // -----------------------------
  // PLANNER
  // -----------------------------
  Future<void> addPlanner(PlannerModel planner) async {
    await _client.from('planners').insert(planner.toSupabaseMap());
  }

  Future<List<PlannerModel>> fetchPlanners() async {
    final res = await _client.from('planners').select().order('date');
    return (res as List)
        .map((e) => PlannerModel.fromMap(e))
        .toList();
  }

  // -----------------------------
  // ROADMAP
  // -----------------------------
  Future<int> addRoadmap(RoadmapModel roadmap) async {
    final res = await _client
        .from('roadmaps')
        .insert(roadmap.toSupabaseMap(currentUser!.id))
        .select()
        .single();

    return res['id'];
  }

  Future<void> addRoadmapSteps(List<RoadmapStep> steps) async {
    final data = steps.map((e) => e.toSupabaseMap()).toList();
    await _client.from('roadmap_steps').insert(data);
  }

  Future<List<RoadmapModel>> fetchRoadmapsWithSteps() async {
    final res = await _client.from('roadmaps').select('''
      id,
      category,
      roadmap_steps (
        id,
        roadmap_id,
        title,
        description,
        iscompleted
      )
    ''');

    final List<RoadmapModel> roadmaps = [];

    for (final r in res) {
      final steps = (r['roadmap_steps'] as List)
          .map((s) => RoadmapStep.fromMap(s))
          .toList();

      roadmaps.add(
        RoadmapModel(
          id: r['id'],
          category: r['category'],
          steps: steps,
        ),
      );
    }

    return roadmaps;
  }

  // -----------------------------
  // CHAT
  // -----------------------------
  Future<void> addChatMessage(ChatMessageModel msg) async {
    await _client.from('chat_messages').insert(
          msg.toSupabaseMap(currentUser!.id),
        );
  }

  Future<List<ChatMessageModel>> fetchChatMessages() async {
    final res = await _client
        .from('chat_messages')
        .select()
        .order('created_at');

    return (res as List)
        .map((e) => ChatMessageModel.fromMap(e))
        .toList();
  }

  // -----------------------------
  // PROFILE
  // -----------------------------
  Future<void> saveProfile(UserProfile profile) async {
    await _client.from('profiles').upsert(
          profile.toSupabaseMap(currentUser!.id),
        );
  }

 Future<UserProfile?> fetchProfile() async {
  try {
    final res = await _client
        .from('profiles')
        .select()
        .eq('id', currentUser!.id)
        .single();

    return UserProfile.fromMap(res);
  } catch (e) {
    // no profile found or other error
    return null;
  }
}

// -----------------------------
  // AUTH
  // -----------------------------

  Future<void> signOut() async {
    await _client.auth.signOut();
  }


  // -----------------------------
// CHAT
// -----------------------------
Future<void> clearChatMessages() async {
  final userId = currentUser?.id;
  if (userId == null) return;

  await _client
      .from('chat_messages')
      .delete()
      .eq('user_id', userId);
}

// -----------------------------
// ROADMAP (UPDATE METHODS)
// -----------------------------

// update roadmap category if needed
Future<void> updateRoadmap(RoadmapModel roadmap) async {
  await _client
      .from('roadmaps')
      .update(roadmap.toSupabaseMap(currentUser!.id))
      .eq('id', roadmap.id!);
}

// update single roadmap step (toggle complete etc.)
Future<void> updateRoadmapStep(RoadmapStep step) async {
  await _client
      .from('roadmap_steps')
      .update(step.toSupabaseMap())
      .eq('id', step.id!);
}

// delete a roadmap (also deletes steps because of cascade)
Future<void> deleteRoadmap(int roadmapId) async {
  await _client
      .from('roadmaps')
      .delete()
      .eq('id', roadmapId);
}

// delete all steps of a roadmap only
Future<void> deleteRoadmapSteps(int roadmapId) async {
  await _client
      .from('roadmap_steps')
      .delete()
      .eq('roadmap_id', roadmapId);
}



}
