import 'package:flutter/material.dart';
import 'package:make_plan/model/todo_model.dart';
import 'package:make_plan/viewmodel/todo_provider.dart';
import 'package:provider/provider.dart';

class PriorityTaskTile extends StatelessWidget {
  final TodoModel todo;

  const PriorityTaskTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TodoProvider>();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) => provider.toggletodo(todo.id!),
        ),
        title: Text(
          todo.taskName,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            decoration:
                todo.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(todo.description),
        trailing: const Icon(
          Icons.star,
          color: Colors.amber,
        ),
      ),
    );
  }
}
