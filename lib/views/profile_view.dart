import 'package:flutter/material.dart';
import 'package:make_plan/views/edit_profile_view.dart';
import 'package:make_plan/widgets/profile/profile_actions.dart';
import 'package:make_plan/widgets/profile/profile_header.dart';
import 'package:provider/provider.dart';
import '../viewmodel/profile_provider.dart';
import 'about_app_view.dart';
import 'help_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ProfileHeader(),
          const SizedBox(height: 30),

          ProfileActions(
            onEdit: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EditProfileView(),
                ),
              );
            },
            onSettings: () {
              // open settings later
            },
            onAbout: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AboutAppView(),
                ),
              );
            },
            onHelp: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const HelpView(),
                ),
              );
            },
            onLogout: () {
              context.read<ProfileProvider>().logout(context);
            },
          ),
        ],
      ),
    );
  }
}
