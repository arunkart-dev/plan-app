import 'package:supabase_flutter/supabase_flutter.dart';

class EmailService {
  static Future<void> sendReminderEmail({
    required String email,
    required String title,
    required String message,
  }) async {
    await Supabase.instance.client.functions.invoke(
      'send-reminder-email',
      body: {
        'email': email,
        'title': title,
        'message': message,
      },
    );
  }
}
