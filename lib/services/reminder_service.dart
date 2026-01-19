import 'package:make_plan/model/remainder_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReminderService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> addReminder(Reminder reminder) async {
    await _client.from('reminders').insert(reminder.toMap());
  }

  Future<List<Reminder>> fetchReminders() async {
    final res = await _client.from('reminders').select();
    return (res as List)
        .map((e) => Reminder.fromMap(e))
        .toList();
  }

  Future<void> toggleReminder(String id, bool value) async {
    await _client.from('reminders')
        .update({'is_enabled': value})
        .eq('id', id);
  }
}
