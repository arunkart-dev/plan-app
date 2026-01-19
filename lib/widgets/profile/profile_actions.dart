import 'package:flutter/material.dart';
import 'profile_tile.dart';

class ProfileActions extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onSettings;
  final VoidCallback onAbout;
  final VoidCallback onHelp;
  final VoidCallback onLogout;

  const ProfileActions({
    super.key,
    required this.onEdit,
    required this.onSettings,
    required this.onAbout,
    required this.onHelp,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileTile(
          icon: Icons.edit,
          title: "Edit Profile",
          onTap: onEdit,
        ),
        ProfileTile(
          icon: Icons.settings,
          title: "Settings",
          onTap: onSettings,
        ),
        ProfileTile(
          icon: Icons.info_outline,
          title: "About App",
          onTap: onAbout,
        ),
        ProfileTile(
          icon: Icons.help_outline,
          title: "Help",
          onTap: onHelp,
        ),
        ProfileTile(
          icon: Icons.logout,
          title: "Logout",
          color: Colors.red,
          onTap: onLogout,
        ),
      ],
    );
  }
}
