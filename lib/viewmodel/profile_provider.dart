import 'dart:async';
import 'package:flutter/material.dart';
import 'package:make_plan/model/profile_model.dart';
import 'package:make_plan/services/supabase_service.dart';
import 'package:make_plan/services/local_notifications.dart';
import 'package:make_plan/views/login_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileProvider extends ChangeNotifier {
  final SupabaseService _supabase = SupabaseService();

  UserProfile? _user;
  UserProfile? get user => _user;

  RealtimeChannel? _profileChannel;
  StreamSubscription<AuthState>? _authSub;

  bool _emailTestSent = false; // prevents duplicate emails

  // ---------------- INIT ----------------
  Future<void> init() async {
    _listenToAuthChanges();
    await loadProfile();
  }

  // ---------------- AUTH LISTENER ----------------
  void _listenToAuthChanges() {
    _authSub =
        Supabase.instance.client.auth.onAuthStateChange.listen((data) async {
      final session = data.session;

      if (session == null) {
        // logged out
        _user = null;
        notifyListeners();
      } else {
        // logged in
        await loadProfile();
        _listenToProfileChanges();

        // ✅ SEND EMAIL AFTER LOGIN (CORRECT PLACE)
        if (!_emailTestSent && session.user.email != null) {
          _emailTestSent = true;
            await NotificationService.sendEmailNotification(
              email: session.user.email!,
              title: 'Welcome to Make Plan 🎉',
              message:
                  'You have successfully logged in. Stay focused and keep planning 💪',
            );
        }
      }
    });
  }

  // ---------------- LOAD PROFILE ----------------
  Future<void> loadProfile() async {
    final currentUser = _supabase.currentUser;

    if (currentUser == null) {
      _user = null;
      notifyListeners();
      return;
    }

    try {
      final profile = await _supabase.fetchProfile();

      if (profile != null) {
        _user = profile;
      } else {
        _user = UserProfile(
          name: currentUser.email ?? "User",
          email: currentUser.email ?? "",
        );
        await _supabase.saveProfile(_user!);
      }

      notifyListeners();
    } catch (e) {
      debugPrint("Load profile error: $e");
    }
  }

  // ---------------- REALTIME LISTENER ----------------
  void _listenToProfileChanges() {
    final userId = _supabase.currentUser?.id;
    if (userId == null) return;

    _profileChannel?.unsubscribe();

    _profileChannel = Supabase.instance.client
        .channel('public:profiles')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'profiles',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'id',
            value: userId,
          ),
          callback: (payload) {
            final data = Map<String, dynamic>.from(payload.newRecord);
            _user = UserProfile.fromMap(data);
            notifyListeners();
          },
        )
        .subscribe();
  }

  // ---------------- UPDATE PROFILE ----------------
  Future<void> updateProfile(String name, String email) async {
    if (_supabase.currentUser == null) return;

    final updated = UserProfile(name: name, email: email);
    _user = updated;
    notifyListeners();

    try {
      await _supabase.saveProfile(updated);
    } catch (e) {
      debugPrint("Update profile error: $e");
    }
  }

  // ---------------- LOGOUT ----------------
  Future<void> logout(BuildContext context) async {
    try {
      await _profileChannel?.unsubscribe();
      _profileChannel = null;

      await _supabase.signOut();

      _user = null;
      notifyListeners();

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => LoginView()),
        (route) => false,
      );
    } catch (e) {
      debugPrint("Logout error: $e");
    }
  }

  // ---------------- DISPOSE ----------------
  @override
  void dispose() {
    _authSub?.cancel();
    _profileChannel?.unsubscribe();
    super.dispose();
  }
}
