import 'package:flutter/material.dart';
import 'package:make_plan/views/about_app_view.dart';
import 'package:make_plan/views/help_view.dart';
import 'package:make_plan/views/profile_view.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- HEADER ----------
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor:
                        theme.colorScheme.primary.withOpacity(0.1),
                    child: Icon(
                      Icons.check_circle_outline,
                      size: 30,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Make Plan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Plan. Focus. Execute.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // ---------- MENU ----------
            _DrawerItem(
              icon: Icons.person_outline,
              title: 'Profile',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfileView(),
                  ),
                );
              },
            ),

            _DrawerItem(
              icon: Icons.info_outline,
              title: 'About App',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AboutAppView(),
                  ),
                );
              },
            ),

            _DrawerItem(
              icon: Icons.help_outline,
              title: 'Help',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HelpView(),
                  ),
                );
              },
            ),

            const Spacer(),

            // ---------- FOOTER ----------
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------- Drawer Item -----------------
class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 22, color: Colors.grey),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
