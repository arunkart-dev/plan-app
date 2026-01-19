import 'package:flutter/material.dart';
import 'package:make_plan/model/remainder_model.dart';
import 'package:make_plan/services/local_notifications.dart';
import 'package:make_plan/services/reminder_service.dart';

class ReminderProvider extends ChangeNotifier {
  final ReminderService _service = ReminderService();

  List<Reminder> _reminders = [];
  List<Reminder> get reminders => _reminders;

  Future<void> loadReminders() async {
    _reminders = await _service.fetchReminders();
    notifyListeners();
  }

  Future<void> createReminder(Reminder r) async {
    await _service.addReminder(r);

    await NotificationService.schedule(
      id: r.hashCode,
      title: "Task Reminder",
      body: "Time to work on your task",
      time: r.remindAt,
    );

    await loadReminders();
  }

  Future<void> toggle(String id, bool v) async {
    await _service.toggleReminder(id, v);
    await loadReminders();
  }
}
