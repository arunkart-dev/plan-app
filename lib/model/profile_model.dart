class UserProfile {
  String name;
  String email;

  UserProfile({
    required this.name,
    required this.email,
  });

  // ---------------------------
  // Supabase mapper
  // ---------------------------
  Map<String, dynamic> toSupabaseMap(String userId) {
    return {
      'id': userId,
      'name': name,
      'email': email,
    };
  }

  // ---------------------------
  // SQLite mapper (optional)
  // ---------------------------
  Map<String, dynamic> toSqliteMap() {
    return {
      'name': name,
      'email': email,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      name: map['name'],
      email: map['email'],
    );
  }
}
