import 'package:flutter/material.dart';
import 'package:make_plan/views/important_task_view.dart';
import 'package:make_plan/views/plan_view.dart';
import 'package:make_plan/views/roadmap._view.dart';
import 'package:provider/provider.dart';

import '../viewmodel/bottom_nav_provider.dart';
import 'todo_list_view.dart';
import 'progress_view.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<BottomNavProvider>();

    final screens = [
      const TodoListView(),
      const ProgressView(),
      const Priority(),
      const PlannerView(),
      const RoadmapView(),
    ];

    return Scaffold(
      body: screens[navProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navProvider.currentIndex,
        onTap: navProvider.changeIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Priority',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            label: 'Planner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.route),
            label: 'Roadmap',
          ),
        ],
      ),
    );
  }
}
