import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends ChangeNotifier {
  final _supabase = Supabase.instance.client;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  User? _currentUser;
  User? get currentUser => _currentUser;

  // ---------------- INIT ----------------
  AuthProvider() {
    _currentUser = _supabase.auth.currentUser;
  }

  // ---------------- SIGNUP ----------------
  Future<void> signup(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      _currentUser = response.user;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("Something went wrong. Try again.");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ---------------- LOGIN ----------------
  Future<void> login(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      _currentUser = response.user;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("Something went wrong. Try again.");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ---------------- LOGOUT ----------------
  Future<void> logout() async {
    await _supabase.auth.signOut();
    _currentUser = null;
    notifyListeners();
  }

  // ---------------- SESSION RESTORE ----------------
  void loadSession() {
    _currentUser = _supabase.auth.currentUser;
    notifyListeners();
  }
}
