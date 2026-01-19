import 'package:flutter/material.dart';
import 'package:make_plan/viewmodel/profile_provider.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<ProfileProvider>().user;

    // 🔹 When user is not logged in yet
    if (user == null) {
      return const Column(
        children: [
          CircleAvatar(
            radius: 45,
            child: Icon(Icons.person, size: 40),
          ),
          SizedBox(height: 10),
          Text(
            "Not logged in",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text("Please sign in to view profile"),
        ],
      );
    }

    // 🔹 When user is logged in
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          child: Text(
            user.name.isNotEmpty
                ? user.name[0].toUpperCase()
                : "?",
            style: const TextStyle(fontSize: 28),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          user.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(user.email),
      ],
    );
  }
}
