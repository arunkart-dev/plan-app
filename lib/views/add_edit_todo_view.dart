import 'package:flutter/material.dart';
import '../model/todo_model.dart';
import '../widgets/todo_form.dart';

class AddEditTodoView extends StatelessWidget {
  final TodoModel? todo;

  const AddEditTodoView({super.key, this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo == null ? "Add Plan" : "Edit Plan"),
      ),
      body: TodoForm(todo: todo),
    );
  }
}
