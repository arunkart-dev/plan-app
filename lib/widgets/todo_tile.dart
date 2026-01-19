import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:make_plan/viewmodel/todo_provider.dart';
import 'package:make_plan/views/add_edit_todo_view.dart';
import 'package:provider/provider.dart';
import '../model/todo_model.dart';

class TodoTile extends StatelessWidget {
  final TodoModel todo;

  const TodoTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TodoProvider>();
    final theme = Theme.of(context);
    final formattedDate =
        DateFormat('dd MMM yyyy · hh:mm a').format(todo.dateTime);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddEditTodoView(todo: todo),
          ),
        );
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- CHECK ----------
            GestureDetector(
              onTap: () => provider.toggletodo(todo.id!),
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: todo.isCompleted
                        ? theme.colorScheme.primary
                        : Colors.grey.shade400,
                  ),
                  color: todo.isCompleted
                      ? theme.colorScheme.primary
                      : Colors.transparent,
                ),
                child: todo.isCompleted
                    ? const Icon(
                        Icons.check,
                        size: 14,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),

            const SizedBox(width: 14),

            // ---------- CONTENT ----------
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          todo.taskName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            color: todo.isCompleted
                                ? Colors.grey
                                : null,
                          ),
                        ),
                      ),

                      // ⭐ PRIORITY
                      GestureDetector(
                        onTap: () => provider.togglePriority(todo.id!),
                        child: Icon(
                          todo.isPriority
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          size: 20,
                          color: todo.isPriority
                              ? Colors.amber
                              : Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),

                  if (todo.description.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      todo.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],

                  const SizedBox(height: 8),

                  // ---------- DATE ----------
                  Text(
                    formattedDate,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),

            // ---------- DELETE ----------
            GestureDetector(
              onTap: () => provider.delete(todo.id!),
              child: Padding(
                padding: const EdgeInsets.only(left: 8, top: 2),
                child: Icon(
                  Icons.close_rounded,
                  size: 18,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
