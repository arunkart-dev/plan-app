import 'package:flutter/material.dart';
import 'package:make_plan/viewmodel/todo_provider.dart';
import 'package:provider/provider.dart';
import '../model/todo_model.dart';

class TodoForm extends StatefulWidget {
  final TodoModel? todo;

  const TodoForm({super.key, this.todo});

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  late TextEditingController taskController;
  late TextEditingController descController;

  @override
  void initState() {
    super.initState();
    taskController =
        TextEditingController(text: widget.todo?.taskName ?? '');
    descController =
        TextEditingController(text: widget.todo?.description ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TodoProvider>();
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------- TITLE ----------
          Text(
            widget.todo == null ? 'New Task' : 'Edit Task',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),

          // ---------- TASK NAME ----------
          TextField(
            controller: taskController,
            decoration: const InputDecoration(
              labelText: 'Task name',
              hintText: 'What do you want to do?',
              border: InputBorder.none,
            ),
          ),

          const Divider(height: 24),

          // ---------- DESCRIPTION ----------
          TextField(
            controller: descController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Add more details (optional)',
              border: InputBorder.none,
            ),
          ),

          const SizedBox(height: 32),

          // ---------- ACTION BUTTON ----------
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                if (taskController.text.trim().isEmpty) return;

                if (widget.todo == null) {
                  provider.add(
                    TodoModel(
                      id: DateTime.now().millisecondsSinceEpoch,
                      taskName: taskController.text,
                      description: descController.text,
                      dateTime: DateTime.now(),
                      isCompleted: false,
                    ),
                  );
                } else {
                  provider.edit(
                    widget.todo!.id!,
                    TodoModel(
                      id: widget.todo!.id,
                      taskName: taskController.text,
                      description: descController.text,
                      dateTime: widget.todo!.dateTime,
                      isCompleted: widget.todo!.isCompleted,
                    ),
                  );
                }

                Navigator.pop(context);
              },
              child: Text(
                widget.todo == null ? 'Add task' : 'Update task',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
