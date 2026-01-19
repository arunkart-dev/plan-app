import 'package:flutter/material.dart';
import 'package:make_plan/viewmodel/search_provider.dart';
import 'package:make_plan/viewmodel/todo_provider.dart';
import 'package:make_plan/widgets/appdrawer.dart';
import 'package:provider/provider.dart';

import '../widgets/todo_tile.dart';
import '../widgets/empty_view.dart';
import '../widgets/search_bar_widget.dart';
import 'add_edit_todo_view.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.watch<TodoProvider>();
    final searchQuery = context.watch<SearchProvider>().query;

    // 🔍 Filtered lists (logic delegated to provider)
    final allFilteredTodos = todoProvider.searchTodos(searchQuery);
    final completedFilteredTodos = todoProvider
        .completedTodos
        .where((t) =>
            t.taskName.toLowerCase().contains(searchQuery) ||
            t.description.toLowerCase().contains(searchQuery))
        .toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: const Text('Make Plan'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: Column(
          children: [
            // 🔍 SEARCH BAR
            const SearchBarWidget(),

            // 📋 TAB CONTENT
            Expanded(
              child: TabBarView(
                children: [
                  // 🔹 ALL TASKS TAB
                  allFilteredTodos.isEmpty
                      ? const EmptyView()
                      : ListView.builder(
                          itemCount: allFilteredTodos.length,
                          itemBuilder: (context, index) {
                            return TodoTile(
                              todo: allFilteredTodos[index],
                            );
                          },
                        ),

                  // 🔹 COMPLETED TASKS TAB
                  completedFilteredTodos.isEmpty
                      ? const EmptyView()
                      : ListView.builder(
                          itemCount: completedFilteredTodos.length,
                          itemBuilder: (context, index) {
                            return TodoTile(
                              todo: completedFilteredTodos[index],
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AddEditTodoView(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
